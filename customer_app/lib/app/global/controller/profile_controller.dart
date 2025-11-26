import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customer_app/app/global/models/user_model.dart';
import 'package:customer_app/app/screens/welcome/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  bool isLoading = false;
  UserModel? userModel;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    fetchUserProfile();
  }

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
  bool get hasUserData => userModel != null;
}
