import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customer_app/app/core/constants/consts.dart';
import 'package:customer_app/app/core/utils/toasts_msg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class KycController extends GetxController {
  static KycController get to => Get.find();

  final ImagePicker _picker = ImagePicker();

  // customize the slots as you want
  final List<String> docKeys = ['id', 'license', 'extra1', 'criminal'];

  // picked file for preview (key -> Rxn<File>)
  final Map<String, Rxn<File>> pickedFiles = {};

  // text controllers for id numbers
  final Map<String, TextEditingController> idControllers = {};

  // Upload state
  final RxBool isUploading = false.obs;

  // progress map (key -> RxDouble). We make access safe.
  final Map<String, RxDouble> uploadProgress = {};

  KycController() {
    for (var k in docKeys) {
      pickedFiles[k] = Rxn<File>();
      idControllers[k] = TextEditingController();
      uploadProgress[k] = 0.0.obs;
    }
  }

  /// Pick image for a specific key
  Future<void> pickImage(String key, {bool fromCamera = false}) async {
    try {
      final XFile? xfile = await _picker.pickImage(
        source: fromCamera ? ImageSource.camera : ImageSource.gallery,
        imageQuality: 80,
      );
      if (xfile == null) return;

      pickedFiles[key]!.value = File(xfile.path);
      update();
    } catch (e) {
      print('pickImage error: $e');
      Get.snackbar('Error', 'Failed to pick image');
    }
  }

  /// Remove a picked image
  void removePicked(String key) {
    pickedFiles[key]!.value = null;
    update();
  }

  /// Safe getter/initializer for uploadProgress[key]
  RxDouble _ensureProgress(String key) {
    if (uploadProgress[key] == null) {
      uploadProgress[key] = 0.0.obs;
    }
    return uploadProgress[key]!;
  }

  /// Upload file and return download URL. Updates progress safely.
  Future<String> _uploadFile(File file, String storagePath, String key) async {
    final ref = FirebaseStorage.instance.ref().child(storagePath);
    final uploadTask = ref.putFile(file);

    // ensure progress entry exists
    final progressRx = _ensureProgress(key);

    // Listen to progress safely
    uploadTask.snapshotEvents.listen((taskSnap) {
      try {
        if (taskSnap.totalBytes > 0) {
          final progress = taskSnap.bytesTransferred / taskSnap.totalBytes;
          progressRx.value = progress;
          update();
        }
      } catch (e) {
        // defensive - don't let listener crash the app
        print('_uploadFile snapshotEvents listener error: $e');
      }
    });

    final snapshot = await uploadTask.whenComplete(() {});
    final url = await snapshot.ref.getDownloadURL();

    // reset progress
    progressRx.value = 0.0;
    update();

    return url;
  }

  Map<String, dynamic> _buildDocMap({
    required String docType,
    required String idNumber,
    required String url,
    Timestamp? uploadedAt,
  }) {
    return {
      'docType': docType,
      'idNumber': idNumber,
      'url': url,
      'uploadedAt': uploadedAt ?? Timestamp.now(),
      'verified': false,
    };
  }

  /// Submit docs: **requires both image AND id number for each slot** the user includes.
  Future<void> submitAllDocs() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) {
      Get.snackbar('Error', 'User not logged in');
      return;
    }

    isUploading.value = true;
    update();

    try {
      final List<Map<String, dynamic>> docsToAdd = [];

      // Validate: user must provide at least one slot with both image+id
      bool hasAtLeastOneValid = false;

      for (final key in docKeys) {
        final File? picked = pickedFiles[key]!.value;
        final String idNumber = idControllers[key]!.text.trim();

        if (picked != null && idNumber.isNotEmpty) {
          hasAtLeastOneValid = true;

          final filename =
              '${key}_${DateTime.now().millisecondsSinceEpoch.toString()}.jpg';
          final storagePath = 'users/$uid/kyc/$filename';

          // upload file
          final url = await _uploadFile(picked, storagePath, key);

          final docMap = _buildDocMap(
            docType: key,
            idNumber: idNumber,
            url: url,
            uploadedAt: Timestamp.now(),
          );
          docsToAdd.add(docMap);
        } else if (picked != null && idNumber.isEmpty) {
          // user uploaded image but didn't provide ID => show error and stop
          Get.snackbar(
            'Validation',
            'Please enter ID/Document number for ${key.toUpperCase()}',
          );
          // You may prefer to continue and show aggregated error — here we stop early
          isUploading.value = false;
          update();
          return;
        } else if (picked == null && idNumber.isNotEmpty) {
          // user entered id but didn't upload image => require image
          Get.snackbar(
            'Validation',
            'Please upload an image for ${key.toUpperCase()}',
          );
          isUploading.value = false;
          update();
          return;
        }
        // else: both empty => ignore this slot
      }

      if (!hasAtLeastOneValid) {
        Get.snackbar(
          'Info',
          'Provide at least one document with image and ID number.',
        );
        isUploading.value = false;
        update();
        return;
      }

      // Append docsToAdd into additionalInfo and set isDocSubmitted true + updatedAt server timestamp
      final userDocRef = FirebaseFirestore.instance
          .collection('users')
          .doc(uid);

      final writeMap = <String, dynamic>{
        'additionalInfo': FieldValue.arrayUnion(docsToAdd),
        'isDocSubmitted': true,
        'updatedAt': FieldValue.serverTimestamp(),
      };

      await userDocRef.set(writeMap, SetOptions(merge: true));

      // Clear UI after success
      clearAll();

      // Get.snackbar('Success', 'KYC documents submitted successfully');
      showToastMessage(
        "Success",
        "KYC documents submitted successfully",
        kGreenAccent,
      );
    } catch (e, st) {
      print('submitAllDocs error: $e\n$st');
      Get.snackbar('Error', 'Failed to submit KYC documents');
    } finally {
      isUploading.value = false;
      update();
    }
  }

  /// Clear local picked files and text fields
  void clearAll() {
    for (final k in docKeys) {
      try {
        pickedFiles[k]!.value = null;
        idControllers[k]!.clear();
        _ensureProgress(k).value = 0.0;
      } catch (_) {
        // defensive
      }
    }
    update();
  }

  @override
  void onClose() {
    for (final c in idControllers.values) {
      c.dispose();
    }
    super.onClose();
  }
}
