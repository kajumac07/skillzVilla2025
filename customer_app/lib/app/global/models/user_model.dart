class UserModel {
  final String uid;
  final String name;
  final String phNumber;
  final String email;
  final String userTYpe;
  final String kycType;
  final String imageUrl;

  UserModel({
    required this.uid,
    required this.name,
    required this.phNumber,
    required this.email,
    required this.userTYpe,
    required this.kycType,
    required this.imageUrl,
  });

  // Convert model to map (Firestore)
  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "name": name,
      "phNumber": phNumber,
      "email": email,
      "userTYpe": userTYpe,
      "kycType": kycType,
      "imageUrl": imageUrl,
    };
  }

  // Convert Firestore map to model
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map["uid"] ?? "",
      name: map["name"] ?? "",
      phNumber: map["phNumber"] ?? "",
      email: map["email"] ?? "",
      userTYpe: map["userTYpe"] ?? "",
      kycType: map["kycType"] ?? "",
      imageUrl: map["imageUrl"] ?? "",
    );
  }
}
