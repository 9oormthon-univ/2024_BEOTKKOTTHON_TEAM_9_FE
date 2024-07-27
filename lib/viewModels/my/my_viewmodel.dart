import 'package:bommeong/models/my/my_state.dart';
import 'package:get/get.dart';
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
      isHaveDog.value = userInfo.isHaveDog ?? false;
      userName.value = userInfo.userName.toString() ?? "User";
      membertype.value = userInfo.membertype == "B" ? "(예비)반려인" : "입양 공고자";
      useremail.value = userInfo.useremail ?? "User1234@naver.com";
      applyAdoption.value = userInfo.applyAdoption == "A" ? "assets/images/my/progress2.svg" : "assets/images/my/progress1.svg";
      dogImage.value = userInfo.dogImage ?? "assets/images/my/dog.svg";
      // dogname.value = userInfo.dogname ?? "날봄이"; // null일 경우 기본값 설정
    } catch (e) {
      // 에러 처리
      print("Error fetching user and dog info: $e");
    }
  }
}