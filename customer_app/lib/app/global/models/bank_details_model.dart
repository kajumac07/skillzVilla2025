class BankDetailsModel {
  final String accountNumber;
  final String confirmAccountNumber;
  final String ifscCode;
  final String phone;
  final String upiId;
  final String branch;
  final String documentUrl;

  BankDetailsModel({
    required this.accountNumber,
    required this.confirmAccountNumber,
    required this.ifscCode,
    required this.phone,
    required this.upiId,
    required this.branch,
    required this.documentUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      "accountNumber": accountNumber,
      "confirmAccountNumber": confirmAccountNumber,
      "ifscCode": ifscCode,
      "phone": phone,
      "upiId": upiId,
      "branch": branch,
      "documentUrl": documentUrl,
    };
  }

  factory BankDetailsModel.fromMap(Map<String, dynamic>? map) {
    if (map == null) {
      return BankDetailsModel(
        accountNumber: "",
        confirmAccountNumber: "",
        ifscCode: "",
        phone: "",
        upiId: "",
        branch: "",
        documentUrl: "",
      );
    }

    return BankDetailsModel(
      accountNumber: map["accountNumber"] ?? "",
      confirmAccountNumber: map["confirmAccountNumber"] ?? "",
      ifscCode: map["ifscCode"] ?? "",
      phone: map["phone"] ?? "",
      upiId: map["upiId"] ?? "",
      branch: map["branch"] ?? "",
      documentUrl: map["documentUrl"] ?? "",
    );
  }
}
