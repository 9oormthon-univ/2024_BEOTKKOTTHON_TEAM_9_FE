import 'package:get/get.dart';

class ResponsesController extends GetxController {
  // responses 리스트를 관리
  var responses = <Map<String, dynamic>>[].obs;

  // responses 리스트에 새 응답을 추가하는 메서드
  void addResponse(Map<String, dynamic> response) {
    responses.add(response);
  }
}