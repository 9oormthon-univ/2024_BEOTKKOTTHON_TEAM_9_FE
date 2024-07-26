import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:bommeong/models/my/my_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../providers/AuthController.dart';
import 'userpreferences_service.dart';

class UserService {
  static Future<UserInfoModel> fetchItems() async {
    String? mypageAPI = '${dotenv.env['API']}/user/info/${UserPreferences.getMemberId()}';
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');

    if (token == null || token.isEmpty) {
      throw Exception('My page: No access token available');
    }

    final response = await http.get(
      Uri.parse(mypageAPI),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200){
      var data = json.decode(response.body);
      UserInfoModel userInfo = UserInfoModel.fromJson(data['result']);
      return userInfo;
    } else {
      throw Exception('Failed to load user info');
    }
  }
}
