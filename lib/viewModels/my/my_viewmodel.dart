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
  RxString userName = "황현정".obs;
  RxString membertype = "(예비)반려인".obs;
  RxString useremail = "ghkd2271@naver.com".obs;
  RxString applyAdoption = "assets/images/my/progress1.svg".obs;
  RxString dogImage = "assets/images/my/dog.svg".obs;
  RxString dogname = "날봄이".obs;


  @override
  void onInit() {
    super.onInit();
    fetchUserAndDogInfo();
  }

  void fetchUserAndDogInfo() async {
    try {
      UserInfoModel userInfo = await UserService.fetchItems();
      // UserService에서 가져온 데이터로 Rx 변수들을 업데이트합니다.
      isHaveDog.value = userInfo.isHaveDog;
      userImage.value = userInfo.userImage;
      userName.value = userInfo.userName;
      membertype.value = userInfo.membertype;
      useremail.value = userInfo.useremail;
      // applyAdoption 변수 업데이트는 예제 데이터에 없으므로 생략
      dogImage.value = userInfo.dogImage;
      dogname.value = userInfo.dogname;
    } catch (e) {
      // 에러 처리
      print("Error fetching user and dog info: $e");
    }
  }
}