import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customer_app/app/core/constants/consts.dart';
import 'package:customer_app/app/core/utils/toasts_msg.dart';
import 'package:customer_app/app/global/models/bank_details_model.dart';
import 'package:customer_app/app/global/models/plan_details_model.dart';
import 'package:customer_app/app/global/models/user_model.dart';
import 'package:customer_app/app/screens/welcome/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  bool isLoading = false;
  UserModel? userModel;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final ImagePicker _imagePicker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    fetchUserProfile();
  }

  //=================== Fetch user profile ===================//
  Future<void> fetchUserProfile() async {
    isLoading = true;
    update();

    try {
      final User? user = _auth.currentUser;

      if (user == null) {
        Get.offAll(() => WelcomeScreen());
        return;
      }

      DocumentSnapshot userDoc = await _firestore
          .collection('users')
          .doc(user.uid)
          .get();

      if (userDoc.exists && userDoc.data() != null) {
        userModel = UserModel.fromMap(userDoc.data() as Map<String, dynamic>);
        log(
          "ProfileController - Name: ${userModel?.name} | Type: ${userModel?.userType}",
        );
      } else {
        userModel = null;
      }
    } catch (e) {
      log("ProfileController Error: $e");
      userModel = null;
    } finally {
      isLoading = false;
      update();
    }
  }

  // Helper getters for easy access with null safety
  String get userType => userModel?.userType ?? 'customer';
  String get kycType => userModel?.kycType ?? 'customer';
  String get userName => userModel?.name ?? 'User';
  String get userPhone => userModel?.phNumber ?? 'No phone number';
  bool get canEditProfile => userType == "provider" && kycType != "customer";
  bool get hasUserData => userModel != null;

  //===================== upload profile image =====================//

  Future<void> pickAndUploadProfileImage({bool fromCamera = false}) async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        Get.snackbar('Error', 'User not logged in');
        return;
      }

      // Pick image
      final XFile? picked = await _imagePicker.pickImage(
        source: fromCamera ? ImageSource.camera : ImageSource.gallery,
        imageQuality: 80,
      );

      if (picked == null) return;

      final File file = File(picked.path);

      showToastMessage(
        "Uploading",
        "Uploadiing profile image....",
        kGreenAccent,
      );

      // Build storage path
      final String filename =
          'profile_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final String storagePath = 'users/${user.uid}/profile/$filename';

      // Upload to Firebase Storage
      final ref = FirebaseStorage.instance.ref().child(storagePath);
      final uploadTask = ref.putFile(file);

      uploadTask.snapshotEvents.listen((snap) {
        if (snap.totalBytes > 0) {
          final progress = (snap.bytesTransferred / snap.totalBytes) * 100;
          log('Upload is $progress% complete.');
        }
      });

      final TaskSnapshot snapshot = await uploadTask.whenComplete(() {});
      final String downloadUrl = await snapshot.ref.getDownloadURL();

      // Update Firestore user doc with new imageUrl and updatedAt
      final userDocRef = _firestore.collection('users').doc(user.uid);
      await userDocRef.set({
        'imageUrl': downloadUrl,
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      // Update local model so UI updates immediately
      if (userModel != null) {
        userModel = UserModel(
          uid: userModel!.uid,
          name: userModel!.name,
          phNumber: userModel!.phNumber,
          email: userModel!.email,
          userType: userModel!.userType,
          kycType: userModel!.kycType,
          imageUrl: downloadUrl, // <-- updated
          whatsApp: userModel!.whatsApp,
          dob: userModel!.dob,
          additionalInfo: userModel!.additionalInfo,
          bankDetails: userModel!.bankDetails,
          isPhoneVerify: userModel!.isPhoneVerify,
          isDocSubmitted: userModel!.isDocSubmitted,
          isGoogleAccountVerify: userModel!.isGoogleAccountVerify,
          planDetails: PlanDetailsModel(
            durationInMonths: 0,
            expiryDate: Timestamp.now(),
            features: [],
            isActive: false,
            originalPrice: "",
            paymentDocumentId: "",
            planTitle: "",
            planType: "",
            price: "",
            subscriptionDate: Timestamp.now(),
          ),
          isPlanPurchased: false,
          currentPlan: "",
          lastPaymentId: "",
          paymentHistory: [],
          createdAt: userModel!.createdAt,
          updatedAt: Timestamp.now(),
        );
      }

      update(); // refresh UI

      showToastMessage("Success", "Profile image updated", kGreenAccent);
    } on FirebaseException catch (e) {
      // storage / permission errors
      print('FirebaseException uploadProfileImage: ${e.code} ${e.message}');

      showToastMessage("Error", "Failed to upload image ${e.message}", kRed);
    } catch (e, st) {
      print('uploadProfileImage error: $e\n$st');

      showToastMessage("Error", "Something went wrong while uploading", kRed);
    }
  }

  //=================== Update bank details ===================//
  Future<bool> updateBankDetails({
    required String accountNumber,
    required String confirmAccountNumber,
    required String ifscCode,
    required String phone,
    required String upiId,
    required String branch,
    String documentUrl = '',
  }) async {
    isLoading = true;
    update();

    // Basic validation
    accountNumber = accountNumber.trim();
    confirmAccountNumber = confirmAccountNumber.trim();
    ifscCode = ifscCode.trim().toUpperCase();
    phone = phone.trim();
    upiId = upiId.trim();

    // 1) All required fields present
    if (accountNumber.isEmpty ||
        confirmAccountNumber.isEmpty ||
        ifscCode.isEmpty ||
        phone.isEmpty) {
      Get.snackbar(
        'Validation',
        'Please fill required bank details',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }

    // 2) Account numbers match
    if (accountNumber != confirmAccountNumber) {
      Get.snackbar(
        'Validation',
        'Account numbers do not match',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: kRed,
      );
      return false;
    }

    // 3) Simple IFSC validation: 4 letters + 0 + 6 alnum (common)
    final RegExp ifscRegex = RegExp(r'^[A-Z]{4}0[A-Z0-9]{6}$');
    if (!ifscRegex.hasMatch(ifscCode)) {
      Get.snackbar(
        'Validation',
        'Please enter a valid IFSC code',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: kRed,
      );
      return false;
    }

    // 4) Phone basic length check
    if (phone.length < 7) {
      Get.snackbar(
        'Validation',
        'Please enter a valid phone number',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: kRed,
      );
      return false;
    }

    // Build model and map
    final bank = BankDetailsModel(
      accountNumber: accountNumber,
      confirmAccountNumber: confirmAccountNumber,
      ifscCode: ifscCode,
      phone: phone,
      upiId: upiId,
      branch: branch,
      documentUrl: documentUrl,
    );

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        Get.snackbar(
          'Error',
          'User not logged in',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: kRed,
        );
        return false;
      }

      // Write to Firestore (merge so we don't overwrite other fields)
      final docRef = FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid);

      final writeMap = <String, dynamic>{
        'bankDetails': bank.toMap(),
        'updatedAt': FieldValue.serverTimestamp(),
      };

      await docRef.set(writeMap, SetOptions(merge: true));

      // Update local model (so UI reflects changes immediately)
      if (userModel != null) {
        userModel = UserModel(
          uid: userModel!.uid,
          name: userModel!.name,
          phNumber: userModel!.phNumber,
          email: userModel!.email,
          userType: userModel!.userType,
          kycType: userModel!.kycType,
          imageUrl: userModel!.imageUrl,
          whatsApp: userModel!.whatsApp,
          dob: userModel!.dob,
          additionalInfo: userModel!.additionalInfo,
          bankDetails: bank,
          isPhoneVerify: userModel!.isPhoneVerify,
          isDocSubmitted: userModel!.isDocSubmitted,
          isGoogleAccountVerify: userModel!.isGoogleAccountVerify,
          planDetails: PlanDetailsModel(
            durationInMonths: 0,
            expiryDate: Timestamp.now(),
            features: [],
            isActive: false,
            originalPrice: "",
            paymentDocumentId: "",
            planTitle: "",
            planType: "",
            price: "",
            subscriptionDate: Timestamp.now(),
          ),
          isPlanPurchased: false,
          currentPlan: "",
          lastPaymentId: "",
          paymentHistory: [],
          createdAt: userModel!.createdAt,
          updatedAt: Timestamp.now(),
        );
      }

      update(); // refresh UI
      Get.snackbar(
        'Success',
        'Bank details updated',
        snackPosition: SnackPosition.BOTTOM,
      );

      return true;
    } catch (e, st) {
      log('updateBankDetails error: $e\n$st');
      Get.snackbar(
        'Error',
        'Failed to update bank details',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    } finally {
      isLoading = false;
      update();
    }
  }
}
