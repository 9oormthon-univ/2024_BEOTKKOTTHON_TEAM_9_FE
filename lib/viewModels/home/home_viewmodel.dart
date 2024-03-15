import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:bommeong/models/home/doglist_state.dart';
import 'package:bommeong/services/user_service.dart';

class HomeViewModel extends GetxController {
  final PagingController<int, DogList> pagingController = PagingController(firstPageKey: 0);
  final GetDogList apiService = GetDogList();

  @override
  void onInit() {
    super.onInit();
    pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await apiService.fetchItems(pageKey); // API 서비스를 사용하여 데이터를 가져옵니다.
      num pageSize = 6;
      final isLastPage = newItems.length < pageSize; // pageSize는 페이지당 아이템 수입니다.
      if (isLastPage) {
        pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      pagingController.error = error;
    }
  }

  @override
  void onClose() {
    pagingController.dispose();
    super.onClose();
  }
}
