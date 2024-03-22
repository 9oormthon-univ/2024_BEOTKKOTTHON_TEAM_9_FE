import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:bommeong/models/home/dog_state.dart';
import 'package:bommeong/services/user_service.dart';


class DogInfoViewModel extends GetxController {
  final GetDogInfo apiService = GetDogInfo();
  RxInt dogId = 0.obs;
  DogInfo items = DogInfo(id: 0, name: "", age: "", type: "", tags: ['',''], dogTalk: "", imagePath: "");

  @override
  void onInit() {
    super.onInit();
    //fetchPage(dogId.value);
  }

  Future<void> fetchPage(int id) async {
    try {
      await setId(id);
      final newItems = await apiService.fetchItems(id); // API로부터 아이템들을 가져옴// 기존 아이템들을 모두 제거
      items = newItems; // 가져온 아이템들을 items 리스트에 추가
    } catch (e) {
      // 에러 처리
      Get.snackbar("Error", "Could not fetch items: ${e.toString()}");
    }

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
