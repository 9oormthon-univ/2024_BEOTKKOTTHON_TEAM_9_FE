// user_service.dart
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../providers/AuthController.dart';
import 'user_service.dart';
import 'userpreferences_service.dart';
class UserService {
  String? loginAPI = dotenv.env['loginAPI'];

  Future<bool> attemptLogIn(String email, String password) async {
      AuthService authService = AuthService();
      authService.login();
      final authController = Get.put(AuthController());

    final response = await http.post(
      Uri.parse(loginAPI!),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'email': email,
        'password': password,
      }),
    );
    if (response.statusCode == 200) {
      // 응답에서 accessToken 추출
      var data = json.decode(response.body);
      String accessToken = data['result']['access_token'];
      int memberId = data['result']['memberId'];
      authController.setToken(accessToken);
      authController.setMemberId(memberId);

      // 사용자 정보를 저장
      await UserPreferences.setMemberId(memberId);
      await UserPreferences.setEmail(data['result']['email']);
      await UserPreferences.setName(data['result']['name']);
      await UserPreferences.setMemberType(data['result']['memberType']);
      return true;
    } else {
      return false;
    }
  }

  // Future<bool> attemptLogIn(String email, String password) async {
  //   // 인위적인 지연을 만들어 실제 API 호출과 유사한 상황을 만듭니다.
  //   await Future.delayed(Duration(seconds: 2));
  //
  //   // 예제를 위한 더미 응답 데이터
  //   var dummyResponse = {
  //     'statusCode': 200,
  //     'body': json.encode({
  //       'message': 'Success',
  //       'user': {
  //         'id': 1,
  //         'name': '사용자 이름',
  //         'email': email,
  //         // 다른 사용자 정보들
  //       }
  //     }),
  //   );
  //   return response.statusCode == 200;
  // }

  // Future<bool> attemptLogIn(String email, String password) async {
  //   // 인위적인 지연을 만들어 실제 API 호출과 유사한 상황을 만듭니다.
  //   await Future.delayed(Duration(seconds: 2));
  //   AuthService authService = AuthService();
  //   authService.login();

  //   // 예제를 위한 더미 응답 데이터
  //   var dummyResponse = {
  //     'statusCode': 200,
  //     'body': json.encode({
  //       'message': 'Success',
  //       'user': {
  //         'id': 1,
  //         'name': '사용자 이름',
  //         'email': email,
  //         // 다른 사용자 정보들
  //       }
  //     }),
  //   };

  //   if (email == '1' && password == '1') {
  //     print('더미 로그인 성공: ${dummyResponse['body']}');
  //     return true; // 성공으로 간주
  //   } else {
  //     print('더미 로그인 실패');
  //     return false; // 실패로 간주
  //   }
  // }

  Future<bool> signInWithApple(String identityToken, String authorizationCode) async {
    try {
      final response = await http.post(
        Uri.parse('$loginAPI/auth/apple'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'identityToken': identityToken,
          'authorizationCode': authorizationCode,
        }),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        var data = json.decode(response.body);

        // 데이터 구조 확인 및 안전한 접근
        if (data != null && data['result'] is Map<String, dynamic>) {
          var result = data['result'];
          String? accessToken = result['access_token'] as String?;
          int? memberId = result['memberId'] as int?;
          String? email = result['email'] as String?;
          String? name = result['name'] as String?;
          String? memberType = result['memberType'] as String?;

          if (accessToken != null && memberId != null) {
            final authController = Get.find<AuthController>();
            authController.setToken(accessToken);
            authController.setMemberId(memberId);

            await UserPreferences.setMemberId(memberId);
            await UserPreferences.setEmail(email ?? '');
            await UserPreferences.setName(name ?? '');
            await UserPreferences.setMemberType(memberType ?? '');

            return true;
          }
        }

        print('Invalid response structure');
        return false;
      } else {
        print('Apple Sign In failed. Status code: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Apple Sign In Error: $e');
      return false;
    }
  }

}
