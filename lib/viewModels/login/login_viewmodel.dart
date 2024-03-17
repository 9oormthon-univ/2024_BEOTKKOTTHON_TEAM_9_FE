// login_view_model.dart
import 'package:flutter/material.dart';
import '../../services/login_service.dart';

class LoginViewModel {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final UserService _userService = UserService();

  Future<bool> attemptLogIn() async {
    return _userService.attemptLogIn(
      emailController.text,
      passwordController.text,
    );
  }
}
