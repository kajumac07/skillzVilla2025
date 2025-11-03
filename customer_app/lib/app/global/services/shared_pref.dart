import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPrefData {
  static const _userTypeKey = 'userType';
  static const _kycTypeKey = 'kycType';

  // -------------------------------
  // Save Methods
  // -------------------------------

  Future<void> saveUserType(String userType) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userTypeKey, userType);
    log('Saved userType: $userType');
  }

  Future<void> saveKycType(String type) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kycTypeKey, type);
    log('Saved kycType: $type');
  }

  // -------------------------------
  // Get Methods
  // -------------------------------

  Future<String?> getUserType() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userTypeKey);
  }

  Future<String?> getKycType() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_kycTypeKey);
  }

  // -------------------------------
  // Clear / Reset (optional utility)
  // -------------------------------
  Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userTypeKey);
    await prefs.remove(_kycTypeKey);
    log('Cleared userType and kycType');
  }
}
