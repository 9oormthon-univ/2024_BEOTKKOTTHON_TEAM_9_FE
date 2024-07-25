// login_view_model.dart
import 'package:bommeong/views/login/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../services/login_service.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class LoginViewModel extends GetxController{
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final UserService _userService = UserService();

  Future<bool> attemptLogIn() async {
    return _userService.attemptLogIn(
      emailController.text,
      passwordController.text,
    );
  }

  Future<void> signInWithApple() async {
    try {
      // 실제 Apple Sign In 대신 모의 구현 사용
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
}
