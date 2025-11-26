import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String name;
  final String phNumber;
  final String email;
  final String userType;
  final String kycType;
  final String imageUrl;

  final List<dynamic> additionalInfo;
  final bool isDocSubmitted;
  final bool isPhoneVerify;
  final bool isGoogleAccountVerify;

  final Timestamp createdAt;
  final Timestamp updatedAt;

  UserModel({
    required this.uid,
    required this.name,
    required this.phNumber,
    required this.email,
    required this.userType,
    required this.kycType,
    required this.imageUrl,
    required this.additionalInfo,
    required this.isPhoneVerify,
    required this.isDocSubmitted,
    required this.isGoogleAccountVerify,
    required this.createdAt,
    required this.updatedAt,
  });

  // Convert model → Firestore map
  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "name": name,
      "phNumber": phNumber,
      "email": email,
      "userType": userType,
      "kycType": kycType,
      "imageUrl": imageUrl,
      "additionalInfo": additionalInfo,
      "isPhoneVerify": isPhoneVerify,
      "isDocSubmitted": isDocSubmitted,
      "isGoogleAccountVerify": isGoogleAccountVerify,
      "createdAt": createdAt,
      "updatedAt": updatedAt,
    };
  }

  // Firestore map → Model
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map["uid"] ?? "",
      name: map["name"] ?? "",
      phNumber: map["phNumber"] ?? "",
      email: map["email"] ?? "",
      userType: map["userType"] ?? "",
      kycType: map["kycType"] ?? "",
      imageUrl: map["imageUrl"] ?? "",

      additionalInfo: map["additionalInfo"] != null
          ? List<dynamic>.from(map["additionalInfo"])
          : [],

      isDocSubmitted: map["isDocSubmitted"] ?? false,
      isPhoneVerify: map["isPhoneVerify"] ?? false,
      isGoogleAccountVerify: map["isGoogleAccountVerify"] ?? false,

      createdAt: map["createdAt"] ?? Timestamp.now(),
      updatedAt: map["updatedAt"] ?? Timestamp.now(),
    );
  }
}
