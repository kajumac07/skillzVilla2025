import 'package:cloud_firestore/cloud_firestore.dart';

class PlanDetailsModel {
  final int durationInMonths;
  final Timestamp expiryDate;
  final List<String> features;
  final bool isActive;
  final String originalPrice;
  final String paymentDocumentId;
  final String planTitle;
  final String planType;
  final String price;
  final Timestamp subscriptionDate;

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

  // ✅ Helper to create an empty/default model cleanly
  factory PlanDetailsModel.empty() {
    return PlanDetailsModel(
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
    );
  }

  // ✅ This function is correct, but YOU MUST CALL IT in UserModel
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
