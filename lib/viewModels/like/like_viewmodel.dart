import 'package:bommeong/models/like/like_state.dart';
import 'package:bommeong/services/like_service.dart';
import 'package:bommeong/services/userpreferences_service.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:bommeong/models/home/dog_state.dart';
import 'package:bommeong/services/user_service.dart';

class LikeViewModel extends GetxController {
  final PagingController<int, DogList> pagingController = PagingController(firstPageKey: 0);
  final GetLikeDogList apiService = GetLikeDogList();
  final isHaveDog = true.obs;
  var dogLikeStatus = <int, RxBool>{}.obs;

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


  Future<void> toggleLike(int dogId) async {
    bool isLiked = dogLikeStatus[dogId]?.value ?? false;

    LikeRequest request = LikeRequest(
      memberId: '${UserPreferences.getMemberId()}', // 실제 memberId를 사용하세요.
      postId: "$dogId",
      flag: isLiked ? "remove" : "register",
    );


    LikeService apiService = LikeService();
    bool success = await apiService.toggleLike(request);

    if (success) {
      print("성공했습니더");
      dogLikeStatus[dogId] = RxBool(!isLiked);
    }
  }



  @override
  void onClose() {
    pagingController.dispose();
    super.onClose();
  }

}
