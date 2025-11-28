import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customer_app/app/global/models/bank_details_model.dart';
import 'package:customer_app/app/global/models/plan_details_model.dart';

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
  final bool isPlanPurchased;
  final String currentPlan;
  final String lastPaymentId;
  final List<dynamic> paymentHistory;

  final BankDetailsModel bankDetails;
  final PlanDetailsModel planDetails;
  final num jobsCompleted;
  final num totalEarning;

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
    required this.planDetails,
    required this.isPhoneVerify,
    required this.isDocSubmitted,
    required this.isGoogleAccountVerify,
    required this.isPlanPurchased,
    required this.currentPlan,
    required this.lastPaymentId,
    required this.paymentHistory,
    required this.jobsCompleted,
    required this.totalEarning,
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
      "planDetails": planDetails,
      "isPhoneVerify": isPhoneVerify,
      "isDocSubmitted": isDocSubmitted,
      "isGoogleAccountVerify": isGoogleAccountVerify,
      "isPlanPurchased": isPlanPurchased,
      "currentPlan": currentPlan,
      "lastPaymentId": lastPaymentId,
      "paymentHistory": paymentHistory,
      "jobsCompleted": jobsCompleted,
      "totalEarning": totalEarning,
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
      planDetails: PlanDetailsModel.fromMap(map["planDetails"]),
      isDocSubmitted: map["isDocSubmitted"] ?? false,
      isPhoneVerify: map["isPhoneVerify"] ?? false,
      isGoogleAccountVerify: map["isGoogleAccountVerify"] ?? false,
      isPlanPurchased: map["isPlanPurchased"] ?? false,
      currentPlan: map["currentPlan"] ?? "",
      lastPaymentId: map["lastPaymentId"] ?? "",
      paymentHistory: map["paymentHistory"] != null
          ? List<dynamic>.from(map["paymentHistory"])
          : [],
      jobsCompleted: map["jobsCompleted"] ?? 0,
      totalEarning: map["totalEarning"] ?? 0,
      createdAt: map["createdAt"] ?? Timestamp.now(),
      updatedAt: map["updatedAt"] ?? Timestamp.now(),
    );
  }
}
