import 'package:bommeong/viewModels/chat/chat_viewmodel.dart';
import 'package:bommeong/viewModels/like/like_viewmodel.dart';
import 'package:bommeong/viewModels/my/my_viewmodel.dart';
import 'package:get/get.dart';
import 'package:bommeong/viewModels/home/home_viewmodel.dart';
import 'package:bommeong/viewModels/root/root_viewmodel.dart';

class RootBinding extends Bindings {
  @override
  void dependencies() {
    // ParentViewModel is singleton
    Get.put(RootViewModel());

    Get.lazyPut(() => HomeViewModel());
    Get.lazyPut(() => ChatViewModel());
    Get.lazyPut(() => LikeViewModel());
    Get.lazyPut(() => MyViewModel());
  }
}
