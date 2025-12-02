import 'dart:async';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserController extends GetxController {
  static UserController get to => Get.find();

  bool isKitIssued = false;
  bool isLoading = true;

  StreamSubscription? _subscription;

  @override
  void onInit() {
    super.onInit();
    _checkKitIssuedStatus();
  }

  @override
  void onClose() {
    _subscription?.cancel();
    super.onClose();
  }

  void _checkKitIssuedStatus() {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      isLoading = false;
      isKitIssued = false;
      update();
      return;
    }

    _subscription = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .snapshots()
        .listen(
          (snapshot) {
            isKitIssued = snapshot.data()?['isKitIssued'] ?? false;
            isLoading = false;
            update();
          },
          onError: (error) {
            isLoading = false;
            isKitIssued = false;
            update();
          },
        );
  }
}
