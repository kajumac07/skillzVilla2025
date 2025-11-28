import 'package:cloud_firestore/cloud_firestore.dart';

class PlanDetailsModel {
  final int durationInMonths; // 1/3/6 etc.
  final Timestamp expiryDate; // end date of subscription
  final List<String> features; // list of plan features
  final bool isActive; // true if plan still active
  final String originalPrice; // old price with ₹ or string
  final String paymentDocumentId; // id from 'plan_purchases'
  final String planTitle; // e.g. "3 Month Plan"
  final String planType; // "Launch" | "Platinum" | "Royal"
  final String price; // current price string like ₹600
  final Timestamp subscriptionDate; // start date timestamp

  PlanDetailsModel({
    required this.durationInMonths,
    required this.expiryDate,
    required this.features,
    required this.isActive,
    required this.originalPrice,
    required this.paymentDocumentId,
    required this.planTitle,
    required this.planType,
    required this.price,
    required this.subscriptionDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'durationInMonths': durationInMonths,
      'expiryDate': expiryDate,
      'features': features,
      'isActive': isActive,
      'originalPrice': originalPrice,
      'paymentDocumentId': paymentDocumentId,
      'planTitle': planTitle,
      'planType': planType,
      'price': price,
      'subscriptionDate': subscriptionDate,
    };
  }

  factory PlanDetailsModel.fromMap(Map<String, dynamic> map) {
    return PlanDetailsModel(
      durationInMonths: map['durationInMonths'] ?? 0,
      expiryDate: map['expiryDate'] ?? Timestamp.now(),
      features: map['features'] != null
          ? List<String>.from(map['features'])
          : <String>[],
      isActive: map['isActive'] ?? false,
      originalPrice: map['originalPrice'] ?? '',
      paymentDocumentId: map['paymentDocumentId'] ?? '',
      planTitle: map['planTitle'] ?? '',
      planType: map['planType'] ?? '',
      price: map['price'] ?? '',
      subscriptionDate: map['subscriptionDate'] ?? Timestamp.now(),
    );
  }
}
