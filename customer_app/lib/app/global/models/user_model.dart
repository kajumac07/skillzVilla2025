import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customer_app/app/global/models/bank_details_model.dart';

class UserModel {
  final String uid;
  final String name;
  final String phNumber;
  final String email;
  final String userType;
  final String kycType;
  final String imageUrl;
  final String whatsApp;
  final String dob;

  final List<dynamic> additionalInfo;
  final bool isDocSubmitted;
  final bool isPhoneVerify;
  final bool isGoogleAccountVerify;

  final BankDetailsModel bankDetails;

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
    required this.whatsApp,
    required this.dob,
    required this.additionalInfo,
    required this.bankDetails,
    required this.isPhoneVerify,
    required this.isDocSubmitted,
    required this.isGoogleAccountVerify,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "name": name,
      "phNumber": phNumber,
      "email": email,
      "userType": userType,
      "kycType": kycType,
      "imageUrl": imageUrl,
      "whatsApp": whatsApp,
      "dob": dob,
      "additionalInfo": additionalInfo,
      "bankDetails": bankDetails.toMap(),
      "isPhoneVerify": isPhoneVerify,
      "isDocSubmitted": isDocSubmitted,
      "isGoogleAccountVerify": isGoogleAccountVerify,
      "createdAt": createdAt,
      "updatedAt": updatedAt,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map["uid"] ?? "",
      name: map["name"] ?? "",
      phNumber: map["phNumber"] ?? "",
      email: map["email"] ?? "",
      userType: map["userType"] ?? "",
      kycType: map["kycType"] ?? "",
      imageUrl: map["imageUrl"] ?? "",
      whatsApp: map["whatsApp"] ?? "",
      dob: map["dob"] ?? "",
      additionalInfo: map["additionalInfo"] != null
          ? List<dynamic>.from(map["additionalInfo"])
          : [],
      bankDetails: BankDetailsModel.fromMap(map["bankDetails"]),
      isDocSubmitted: map["isDocSubmitted"] ?? false,
      isPhoneVerify: map["isPhoneVerify"] ?? false,
      isGoogleAccountVerify: map["isGoogleAccountVerify"] ?? false,
      createdAt: map["createdAt"] ?? Timestamp.now(),
      updatedAt: map["updatedAt"] ?? Timestamp.now(),
    );
  }
}
