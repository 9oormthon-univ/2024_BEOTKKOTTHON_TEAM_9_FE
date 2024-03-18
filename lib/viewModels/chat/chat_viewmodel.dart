import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:bommeong/models/home/dog_state.dart';
import 'package:bommeong/services/user_service.dart';

class ChatViewModel extends GetxController {
  RxBool isHaveChat = true.obs;
  final PagingController<int, ChatList> pagingController = PagingController(firstPageKey: 0);
  final GetChatList apiService = GetChatList();


  @override
  void onInit() {
    super.onInit();
    pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }


  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await apiService.fetchItems(pageKey);
      num pageSize = 6;
      final isLastPage = newItems.length < pageSize;
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
    super.onClose();
    pagingController.dispose();
  }


}
