import 'package:get/get.dart';

class AuthController extends GetxController {
  var accessToken = ''.obs; // Observable variable for access token
  var memberId = ''.obs; // Observable variable for member ID

  // Method to set the access token
  void setToken(String token) {
    accessToken.value = token;
  }

  // Method to set the member ID
  void setMemberId(String id) { // Avoid name conflict and clarify method purpose
    memberId.value = id; // Correctly refer to the RxString variable
  }

  // Getter for member ID
  String get memberIdValue => memberId.value; // Correct the getter to return the value

  // Getter for access token
  String get token => accessToken.value;
}
