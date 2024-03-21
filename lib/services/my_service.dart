import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:bommeong/models/my/my_state.dart';
import '../../providers/AuthController.dart';

class UserService {
  static Future<UserInfoModel> fetchItems() async {
    String? mypageAPI = dotenv.env['mypageAPI'];
    var token = Get.find<AuthController>().token;

    final response = await http.get(
      Uri.parse(mypageAPI!),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      UserInfoModel userInfo = UserInfoModel.fromJson(data);

      return userInfo;
    } else {
      throw Exception('Failed to load user info');
    }
  }
}
