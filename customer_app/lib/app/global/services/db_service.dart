import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customer_app/app/global/models/user_model.dart';

class DatabaseServices {
  final String uid;
  DatabaseServices({required this.uid});

  // reference for user collection
  final CollectionReference userDatabase = FirebaseFirestore.instance
      .collection("users");

  // save user data function
  Future<void> saveUserData(UserModel userModel) async {
    return userDatabase
        .doc(uid)
        .set(userModel.toMap(), SetOptions(merge: true));
  }
}
