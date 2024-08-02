// login_view_model.dart
import 'package:bommeong/views/login/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../services/login_service.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../views/login/signin_screen.dart';

class LoginViewModel extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final UserService _userService = UserService();

  final _token = RxString('');

  String get token => _token.value;

  bool get isAuthenticated => _token.value.isNotEmpty;

  @override
  void onInit() {
    super.onInit();
    _loadToken();
  }

  Future<void> _loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    final savedToken = prefs.getString('access_token');
    if (savedToken != null) {
      setToken(savedToken);
    }
  }

  void setToken(String newToken) async {
    _token.value = newToken;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', newToken);
  }

  Future<bool> attemptLogIn() async {
    try {
      String? token = await _userService.attemptLogIn(
        emailController.text,
        passwordController.text,
      );
      // print('Received token: $token');
      if (token != null && token.isNotEmpty) {
        setToken(token);
        return true;
      } else {
        print('Login failed: Token is null or empty');
        return false;
      }
    } catch (e) {
      print('Error during login attempt: $e');
      return false;
    }
  }

  Future<bool> attemptLogOut() async {
    try {
      await _userService.attemptLogOut();
      return true;
    } catch (e) {
      print('Error during login attempt: $e');
      return false;
    }
  }

  Future<void> signInWithApple() async {
    try {
      final credential = await _getMockAppleCredential();

      bool isSuccess = await _userService.signInWithApple(
        credential.identityToken ?? '',
        credential.authorizationCode ?? '',
      );

      if (isSuccess) {
        Get.to(LoadingScreen());
      } else {
        Get.snackbar('로그인 실패', 'Apple 로그인에 실패했습니다.');
      }
    } catch (e) {
      print('Apple Sign In Error: $e');
      Get.snackbar('오류', 'Apple 로그인 중 오류가 발생했습니다.');
    }
  }

  Future<AuthorizationCredentialAppleID> _getMockAppleCredential() async {
    // 실제 로그인 과정을 시뮬레이션하기 위해 약간의 지연 추가
    await Future.delayed(Duration(seconds: 2));

    return AuthorizationCredentialAppleID(
      authorizationCode: 'mock_auth_code_${DateTime.now().millisecondsSinceEpoch}',
      identityToken: 'mock_identity_token_${DateTime.now().millisecondsSinceEpoch}',
      email: 'mock@example.com',
      familyName: 'Doe',
      givenName: 'John',
      userIdentifier: 'mock_user_identifier_${DateTime.now().millisecondsSinceEpoch}',
    );
  }

  Future<void> loginWithKakao() async {
    try {
      if (await isKakaoTalkInstalled()) {
        await UserApi.instance.loginWithKakaoTalk();
      } else {
        await UserApi.instance.loginWithKakaoAccount();
      }
      print('카카오톡으로 로그인 성공');
      User user = await UserApi.instance.me();
      print('사용자 정보: ${user.kakaoAccount?.profile?.nickname}');

      // 회원가입 화면으로 이동하면서 사용자 정보를 전달
      Get.to(() => SignInScreen(
        membertype: "B",
        email: user.kakaoAccount?.email ?? '',
        name: user.kakaoAccount?.profile?.nickname ?? '',
        phone: user.kakaoAccount?.phoneNumber ?? '',
      ));
    } catch (e) {
      print('카카오톡으로 로그인 실패: $e');
    }
  }


  Future<void> logout() async {
    try {
      await UserApi.instance.logout();
      print('로그아웃 성공');
    } catch (e) {
      print('로그아웃 실패: $e');
    }
  }

}
