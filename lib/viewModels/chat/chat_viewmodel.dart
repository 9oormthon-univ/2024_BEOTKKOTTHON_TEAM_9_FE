import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:bommeong/models/home/dog_state.dart';
import 'package:bommeong/services/chat_service.dart';


class ChatViewModel extends GetxController {
  RxBool isHaveChat = true.obs;
  final PagingController<int, ChatList> pagingController = PagingController(firstPageKey: 0);
  RxList<ChatList> chatList = RxList<ChatList>(); // 새로운 반응형 리스트 변수
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
      isHaveChat.value = newItems.isNotEmpty;
      if (newItems.isNotEmpty) {
        if (pageKey == 0) {
          chatList.assignAll(newItems); // 첫 페이지면 리스트를 새로 할당
        } else {
          chatList.addAll(newItems); // 그 외 페이지면 리스트에 추가
        }

        // PagingController 업데이트
        final isLastPage = newItems.length < 6;
        if (isLastPage) {
          pagingController.appendLastPage(newItems);
        } else {
          final nextPageKey = pageKey + newItems.length;
          pagingController.appendPage(newItems, nextPageKey);
        }
      } else if (pageKey == 0) {
        chatList.clear(); // 첫 페이지에 데이터가 없으면 리스트를 비움
      }
    } catch (error) {
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


  @override
  void onClose() {
    super.onClose();
    pagingController.dispose();
  }


}
