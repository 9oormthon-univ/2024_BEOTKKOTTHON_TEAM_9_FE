import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import '../../services/login_service.dart';

class LoginViewModel extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final UserService _userService = UserService();

  Future<bool> attemptLogIn() async {
    return _userService.attemptLogIn(
      emailController.text,
      passwordController.text,
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
      // 로그인 성공 시 필요한 로직 추가
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
