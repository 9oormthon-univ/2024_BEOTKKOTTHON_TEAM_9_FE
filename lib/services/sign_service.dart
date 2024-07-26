import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class UserSignInService {
  String? signAPI = '${dotenv.env['API']}/signup';

  Future<bool> attemptSignIn(String email, String password, String name, String phone, String memberType) async {
    final response = await http.post(
      Uri.parse(signAPI!),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'email': email,
        'password': password,
        'name': name,
        'phone': phone,
        'memberType': memberType,
      }),
    );
    return response.statusCode == 200;
  }
}