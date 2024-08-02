// user_service.dart
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main_app.dart';
import '../providers/AuthController.dart';
import '../utilities/app_routes.dart';
import 'user_service.dart';
import 'userpreferences_service.dart';
import 'package:flutter/material.dart';

class UserService {
  String? loginAPI = '${dotenv.env['API']}/user/login';
  String? logoutAPI = '${dotenv.env['API']}/user/logout';
  bool isLoggedIn = UserPreferences.getEmail().isNotEmpty;

  void restartApp() {
    // 모든 라우트를 제거하고 새로운 인스턴스의 MainApp으로 이동
    Get.offAll(() => MainApp(initialRoute: Routes.LOGIN),
        transition: Transition.fade);

    // 로그인 상태 초기화
    isLoggedIn = false;

    // GetX 컨트롤러 초기화 (만약 사용 중이라면)
    Get.reset();
  }

  Future<String?> attemptLogIn(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse(loginAPI!),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': email,
          'password': password,
        }),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if (data['result'] != null && data['result']['accessToken'] != null) {
          String accessToken = data['result']['accessToken'];
          String refreshToken = data['result']['refreshToken'];
          int memberId = data['result']['memberId'];

          // 토큰 저장
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('access_token', accessToken);
          await prefs.setString('refresh_token', refreshToken);

          // 사용자 정보 저장
          await UserPreferences.setMemberId(memberId);
          await UserPreferences.setEmail(data['result']['email']);
          await UserPreferences.setName(data['result']['name']);
          await UserPreferences.setMemberType(data['result']['memberType']);
          return accessToken;
        }
      }

      print('Login failed. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      return null;
    } catch (e) {
      print('Error during login: $e');
      return null;
    }
  }

  // Todo: 더미 로그인 로직
  // Future<bool> attemptLogIn(String email, String password) async {
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

  Future<dynamic> fetchUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');

    if (token == null) {
      throw Exception('No token found');
    }

    final response = await http.get(
      Uri.parse('$loginAPI/user/info'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load user info');
    }
  }

  Future<void> attemptLogOut() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('refresh_token');

    if (token == null) {
      print('No token found, proceeding with logout');
    } else {
      try {
        final response = await http.get(
          Uri.parse(logoutAPI!),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        );

        if (response.statusCode != 200) {
          print('Failed to logout user. Status code: ${response.statusCode}');
        }
      } catch (e) {
        print('Logout Error: $e');
      }
    }

    // 로컬 데이터 삭제
    await UserPreferences.logout();

    // UI 스레드에서 앱 재시작
    WidgetsBinding.instance.addPostFrameCallback((_) {
      restartApp();
    });
  }

}
