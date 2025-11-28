import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customer_app/app/global/models/plan_model.dart';
import 'package:customer_app/app/screens/providerSide/providerPlans/plans_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentService {
  late Razorpay _razorpay;
  final BuildContext context;

  PaymentService({required this.context});

  // Update the pay method to accept Plan object
  Future<void> pay(
    double amount,
    String packageType,
    Plan plan,
    bool fromSubscription,
  ) async {
    _razorpay = Razorpay();
    var options = {
      'key': "rzp_test_jWDZLNgkvFm2JM",
      'amount': (amount * 100).round(),
      'name': 'Skilz Villa',
      'description': 'Payment for the ${plan.title} - $packageType',
      'retry': {'enabled': true, 'max_count': 3},
      'send_sms_hash': true,
      'prefill': {
        'contact': FirebaseAuth.instance.currentUser?.phoneNumber,
        'email': 'support@skilzvilla.com',
      },
    };

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, (
      PaymentSuccessResponse response,
    ) {
      _handlePaymentSuccess(
        amount,
        response,
        packageType,
        plan,
        fromSubscription,
      );
    });
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);

    try {
      _razorpay.open(options);
    } catch (e) {
      dispose();
      debugPrint('Error: $e');
    }
  }

  void _handlePaymentSuccess(
    double amount,
    PaymentSuccessResponse response,
    String packageType,
    Plan plan,
    bool fromSubscription,
  ) async {
    Fluttertoast.showToast(msg: 'Please wait.....');
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      _showAlertDialog('Error', 'User not found');
      return;
    }
    final userId = user.uid;
    CollectionReference userCollection = FirebaseFirestore.instance.collection(
      'users',
    );
    CollectionReference paymentsCollection = FirebaseFirestore.instance
        .collection('payments');

    // Calculate expiry date
    DateTime subscriptionDate = DateTime.now();
    DateTime expiryDate = subscriptionDate.add(
      Duration(days: plan.durationInMonths * 30),
    );

    try {
      DocumentReference paymentDocRef = paymentsCollection.doc();
      String paymentDocId = paymentDocRef.id;

      await paymentDocRef.set({
        'paymentId': paymentDocId,
        'userID': userId,
        'subscription': packageType,
        'planDetails': {
          'title': plan.title,
          'type': packageType,
          'duration': plan.durationInMonths,
          'price': amount.toString(),
          'originalPrice': plan.oldPrice,
          'features': plan.features,
        },
        'amount': amount.toString(),
        'razorpayPaymentId': response.paymentId,
        'razorpayOrderId': response.orderId,
        'razorpaySignature': response.signature,
        'timepaid': FieldValue.serverTimestamp(),
        'subscriptionDate': FieldValue.serverTimestamp(),
        'expiryDate': expiryDate,
        'status': 'completed',
      });

      // Step 2: Then update user collection with plan details and payment document ID
      await userCollection.doc(userId).update({
        'isPlanPurchased': true,
        'currentPlan': packageType,
        'lastPaymentId': paymentDocId,
        'planDetails': {
          'planTitle': plan.title,
          'planType': packageType,
          'durationInMonths': plan.durationInMonths,
          'price': amount.toString(),
          'originalPrice': plan.oldPrice,
          'features': plan.features,
          'subscriptionDate': FieldValue.serverTimestamp(),
          'expiryDate': expiryDate,
          'isActive': true,
          'paymentDocumentId': paymentDocId,
        },
        'paymentHistory': FieldValue.arrayUnion([paymentDocId]),
      });

      Fluttertoast.showToast(msg: 'Payment Successful!');

      // Show success message
      _showAlertDialog('Success', 'Subscription activated successfully!');
    } catch (error) {
      debugPrint('Error storing payment data: $error');
      _showAlertDialog(
        'Error',
        'Failed to save payment details. Please contact support.',
      );
    }
  }

  void _showAlertDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          ElevatedButton(
            child: const Text('OK'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  void handlePaymentErrorResponse(PaymentFailureResponse response) {
    _showAlertDialog('Payment Failed', 'Description: ${response.message}\n');
  }

  void dispose() {
    _razorpay.clear();
  }
}
