import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:bommeong/models/home/dog_state.dart';
import 'package:bommeong/services/chat_service.dart';


class ChatViewModel extends GetxController {
  RxBool isHaveChat = true.obs;
  final PagingController<int, ChatList> pagingController = PagingController(firstPageKey: 0);
  final GetChatList apiService = GetChatList();


  @override
  void onInit() {
    super.onInit();
    pagingController.addPageRequestListener((pageKey) {
      fetchPage(pageKey);
    });
  }


  Future<void> fetchPage(int pageKey) async {
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
      isHaveChat.value = false;
      pagingController.error = error;
    }
  }

  String formatChatDate(DateTime date) {
    final Duration difference = DateTime.now().difference(date);

    if (difference.inDays >= 1) {
      return '${difference.inDays}일 전';
    } else if (difference.inHours >= 1) {
      return '${difference.inHours}시간 전';
    } else {
      return '${difference.inMinutes}분 전';
    }
  }

  Future<void> updateChatList() async {
    try {
      // 첫 번째 페이지의 데이터를 다시 가져옵니다.
      final newItems = await apiService.fetchItems(0);

      // 새로운 아이템이 있다면, 채팅 상태를 업데이트합니다.
      if (newItems.isNotEmpty) {
        isHaveChat.value = true;

        // PagingController를 리프레시하거나 업데이트하는 로직
        // 여기서는 간단하게 PagingController를 리프레시하는 방법을 사용합니다.
        pagingController.refresh();
      } else {
        isHaveChat.value = false;
      }
    } catch (error) {
      print("Error updating chat list: $error");
    }
  }



  @override
  void onClose() {
    super.onClose();
    pagingController.dispose();
  }


}
