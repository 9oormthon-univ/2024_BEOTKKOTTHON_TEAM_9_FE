import 'package:bommeong/viewModels/chat/chat_viewmodel.dart';
import 'package:bommeong/viewModels/home/doginfo_viewmodel.dart';
import 'package:bommeong/viewModels/like/like_viewmodel.dart';
import 'package:bommeong/viewModels/login/login_viewmodel.dart';
import 'package:bommeong/viewModels/message/message_viewmodel.dart';
import 'package:bommeong/viewModels/my/my_viewmodel.dart';
import 'package:bommeong/viewModels/privacy/privacy_viewmodel.dart';
import 'package:get/get.dart';
import 'package:bommeong/viewModels/home/home_viewmodel.dart';
import 'package:bommeong/viewModels/root/root_viewmodel.dart';
import 'package:bommeong/services/user_service.dart';

class RootBinding extends Bindings {
  @override
  void dependencies() {
    // ParentViewModel is singleton
    Get.put(RootViewModel());
    Get.lazyPut(() => HomeViewModel());
    Get.lazyPut(() => ChatViewModel());
    Get.lazyPut(() => LikeViewModel());
    Get.lazyPut(() => MyViewModel());
    Get.lazyPut(() => DogInfoViewModel(),fenix: true);
    Get.put(LoginViewModel());
    Get.put(PrivacyViewModel());
    //DogInfoViewModel를 최대한 빨리 생성하기위한 코드
    Get.lazyPut(() => MessageViewModel());
  }
}
