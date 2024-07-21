import 'package:get/get.dart';

class AuthController extends GetxController {
  var accessToken = ''.obs; // Observable variable for access token
  var memberId = 0.obs; // Observable variable for member ID, corrected to RxInt

  // Method to set the access token
  void setToken(String token) {
    accessToken.value = token;
  }

  // Method to set the member ID
  void setMemberId(int id) {
    memberId.value = id; // Now correctly refers to the RxInt variable
  }

  // Getter for member ID
  int get memberIdValue => memberId.value; // Name adjusted to avoid conflict

  // Getter for access token
  String get token => accessToken.value;
}
