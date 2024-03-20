import 'package:get/get.dart';

class AuthController extends GetxController {
  var accessToken = ''.obs; // Observable variable

  void setToken(String token) {
    accessToken.value = token;
  }

  String get token => accessToken.value;
}
