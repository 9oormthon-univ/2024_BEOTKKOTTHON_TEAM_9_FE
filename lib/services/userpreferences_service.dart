import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static late SharedPreferences _preferences;

  static const _keyName = 'name';
  static const _keyEmail = 'email';
  static const _keyMemberId = 'memberId';
  static const _keyMemberType = 'memberType';

  static Future init() async => _preferences = await SharedPreferences.getInstance();

  static Future setName(String name) async => await _preferences.setString(_keyName, name);

  static String getName() => _preferences.getString(_keyName) ?? '';

  static Future setEmail(String email) async => await _preferences.setString(_keyEmail, email);

  static String getEmail() => _preferences.getString(_keyEmail) ?? '';

  static Future setMemberId(int memberId) async => await _preferences.setInt(_keyMemberId, memberId);

  static int getMemberId() => _preferences.getInt(_keyMemberId) ?? 0;

  static Future setMemberType(String memberType) async => await _preferences.setString(_keyMemberType, memberType);

  static String getMemberType() => _preferences.getString(_keyMemberType) ?? '';
}
