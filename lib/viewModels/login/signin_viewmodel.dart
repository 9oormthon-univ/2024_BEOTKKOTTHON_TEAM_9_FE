import 'package:bommeong/models/login/sign_state.dart';
import 'package:flutter/material.dart';
import '../../services/sign_service.dart';

class SignInViewModel {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
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

  Future<bool> attemptSignIn() async {
    return _userService.attemptSignIn(
      emailController.text,
      passwordController.text,
      nameController.text,
      phoneController.text,
      "B",
    );
  }

  Future<bool> checkEmail(String text) async {
    return _userService.checkEmail(
      text,
    );
  }
}