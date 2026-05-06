import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class UserStorage {
  static const String currentUserKey = 'current_user_email';

  static Future<void> saveCurrentUser(String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(currentUserKey, email);
  }

  static Future<String?> getCurrentUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(currentUserKey);
  }

  static Future<void> saveUser({
    required String email,
    required Map<String, dynamic> data,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_$email', jsonEncode(data));
    await saveCurrentUser(email);
  }

  static Future<Map<String, dynamic>?> getUser(String email) async {
    final prefs = await SharedPreferences.getInstance();
    final rawData = prefs.getString('user_$email');

    if (rawData == null) return null;

    return jsonDecode(rawData) as Map<String, dynamic>;
  }

  static Future<Map<String, dynamic>?> getCurrentUser() async {
    final email = await getCurrentUserEmail();
    if (email == null) return null;
    return getUser(email);
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(currentUserKey);
  }
  
}