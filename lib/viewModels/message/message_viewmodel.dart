import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:bommeong/models/home/dog_state.dart';
import 'package:bommeong/services/user_service.dart';


class MessageViewModel extends GetxController {
  RxInt dogId = 0.obs;

  @override
  void onInit() {
    super.onInit();
  }




  Future<void> setId(int id) async{
    print("아이디는 : ${id}");
    this.dogId.value = id;
  }


  @override
  void onClose() {
    super.onClose();
  }


}