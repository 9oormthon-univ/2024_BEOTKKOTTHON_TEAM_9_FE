import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static late SharedPreferences _preferences;

  static const _keyUsername = 'username';
  static const _keyEmail = 'email';
  static const _userID = 'userID';

  static Future init() async => _preferences = await SharedPreferences.getInstance();

  static Future setUsername(String username) async => await _preferences.setString(_keyUsername, username);

  static String getUsername() => _preferences.getString(_keyUsername) ?? '';

  static Future setUserID(int userID) async => await _preferences.setInt(_userID, userID);

  static int getUserID() => _preferences.getInt(_userID) ?? 0;

  static Future setEmail(String email) async => await _preferences.setString(_keyEmail, email);

  static String getEmail() => _preferences.getString(_keyEmail) ?? '';
}
