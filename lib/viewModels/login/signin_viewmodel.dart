import 'package:bommeong/models/login/sign_state.dart';
import 'package:flutter/material.dart';
import '../../services/sign_service.dart';

class SignInViewModel {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController membertypeController = TextEditingController();
  final UserSignInService _userService = UserSignInService();

  void printAllControllerValues() {
    print("Email: ${emailController.text}");
    print("Password: ${passwordController.text}");
    print("Name: ${nameController.text}");
    print("Phone: ${phoneController.text}");
    print("MemberType: ${membertypeController.text}");
  }
  // 일단 관리자/멤버는 남겨둚
  Future<bool> attemptSignIn() async {
    return _userService.attemptSignIn(
      emailController.text,
      passwordController.text,
      nameController.text,
      phoneController.text,
      membertypeController.text,
    );
  }
}
