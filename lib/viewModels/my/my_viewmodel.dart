import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../providers/AuthController.dart';

class MyViewModel extends GetxController {
  RxBool isHaveDog = true.obs;
  RxString userName = "황현정".obs;
  RxString userImage = "assets/images/home/face.png".obs;
  RxString useremail = "ghkd2271@naver.com".obs;
  RxString membertype = "(예비)반려인".obs;
  RxString dogImage = "assets/images/my/miniDog.png".obs;
  RxString dogname = "날봄이".obs;

  Future<void> fetchItems(int pageKey) async {
    String? mypageAPI = dotenv.env['mypageAPI'];
    var token = Get.find<AuthController>().token; // AuthController에서 token 가져오기

    final response = await http.get(
      Uri.parse(mypageAPI!),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      isHaveDog.value = data['isHaveDog'];
      userName.value = data['userName'];
      userImage.value = data['userImage'];
      useremail.value = data['useremail'];
      membertype.value = data['membertype'];
      dogname.value = data['dogname'];
      dogImage.value = data['dogImage'];
    } else {
      throw Exception('Failed to load items');
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchItems(0); // 클래스가 초기화될 때 데이터를 가져옴
  }
}
