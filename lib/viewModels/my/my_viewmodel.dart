import 'dart:convert';
import 'package:bommeong/models/my/my_state.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../providers/AuthController.dart';
import 'package:bommeong/services/my_service.dart';

class MyViewModel extends GetxController {
  RxBool isHaveDog = true.obs;
  RxString userImage = "assets/images/home/face.png".obs;
  RxString userName = "공백".obs;
  RxString membertype = "(예비)반려인".obs;
  RxString useremail = "ghkd2271@nate.com".obs;
  RxString applyAdoption = "assets/images/my/progress1.svg".obs;
  RxString dogImage = "".obs;
  RxString dogname = "날봄이".obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserAndDogInfo();
  }

  Future<void> fetchUserAndDogInfo() async {
    try {
      UserInfoModel userInfo = await UserService.fetchItems();
      isHaveDog.value = userInfo.isHaveDog ?? false; // null일 경우 기본값으로 false 설정
      userName.value = userInfo.userName.toString() ?? "황현정"; // null일 경우 기본값 설정
      membertype.value = userInfo.membertype == "B" ? "(예비)반려인" : "입양 공고자"; // null일 경우 기본값 설정
      useremail.value = userInfo.useremail ?? "ghkd2271@naver.com";
      applyAdoption.value = userInfo.applyAdoption == "A" ? "assets/images/my/progress2.svg" : "assets/images/my/progress1.svg"; // null일 경우 기본값 설정
      dogImage.value = userInfo.dogImage ?? "assets/images/my/dog.svg"; // null일 경우 기본값 설정
      // dogname.value = userInfo.dogname ?? "날봄이"; // null일 경우 기본값 설정
    } catch (e) {
      // 에러 처리
      print("Error fetching user and dog info: $e");
    }
  }
}