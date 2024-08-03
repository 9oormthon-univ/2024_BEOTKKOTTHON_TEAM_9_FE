import 'package:bommeong/viewModels/home/doginfo_viewmodel.dart';
import 'package:bommeong/viewModels/like/like_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bommeong/viewModels/home/home_viewmodel.dart';
import 'package:bommeong/views/base/base_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:bommeong/utilities/font_system.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:bommeong/models/home/dog_state.dart';
import 'package:bommeong/viewModels/root/root_viewmodel.dart';
import 'package:bommeong/services/userpreferences_service.dart';

class HomeScreen extends BaseScreen<HomeViewModel> {
  const HomeScreen({super.key});

  @override
  Widget buildBody(BuildContext context) {

    return Column(
      children: [
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.only(left: 30, right: 16),
          alignment: Alignment.centerLeft,
          child: SvgPicture.asset(
            "assets/images/home/BOMMEONG.svg",
            height: 16,
          ),
        ),
        SizedBox(height: 22),
        _Header(),
        SearchInput(),
        SizedBox(height: 30),
        _Middle(),
        SizedBox(height: 20),
        _DogList(),
      ],
    );
  }
  @override
  bool get wrapWithOuterSafeArea => true;
  @override
  bool get wrapWithInnerSafeArea => true;
}

class SearchInput extends GetView<HomeViewModel> {
  const SearchInput({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: controller.searchAddress,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 30),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Color(0xFFFFFFFF), // 박스 색상을 FFFFFF로 변경
          borderRadius: BorderRadius.circular(25), // 둥글기를 25로 변경
          boxShadow: [
            BoxShadow(
              color: Color(0x1F000000), // 000000 색상의 12% 투명도
              blurRadius: 10, // Blur를 10으로 설정
              offset: Offset(0, 2), // 그림자 위치 조정 (선택사항)
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(Icons.search, color: Color(0xFF979797)),
            SizedBox(width: 8),
            Expanded(
              child: Obx(() => Text(
                controller.selectedAddress.value.isEmpty
                    ? '주소를 검색해주세요'
                    : controller.selectedAddress.value,
                style: FontSystem.KR14R.copyWith(
                  color: controller.selectedAddress.value.isEmpty
                      ? Color(0xFF979797)
                      : Colors.black,
                ),
                overflow: TextOverflow.ellipsis,
              )),
            ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 30),
              child: Text("오늘 하루는 어떠세요?",
              style: FontSystem.KR12B.copyWith(color: Color(0xFF979797)),),
            ),
            // ToDO: 인터뷰 스크린 이동용으로 잠시 해놓은 것. 나중에 지우기(InkWell)
            // InkWell(
            //   onTap: () {
            //     Get.to(() => PrivacyConsentScreen());
            //   },
            //   child: Container(
            //     width: Get.width * 0.10,
            //     padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            //     // 패딩 조정으로 버튼 크기 조정
            //     decoration: BoxDecoration(
            //       color: Color(0xFFA273FF), // 배경색 설정
            //       borderRadius: BorderRadius.circular(8), // 모서리 둥글기 반경 설정
            //     ),
            //     child: Text(
            //       '테스트', // 버튼 텍스트
            //       style: FontSystem.KR10B.copyWith(color: Colors.black), // 텍스트 스타일
            //       textAlign: TextAlign.center, // 텍스트 정렬
            //     ),
            //   ),
            // )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 30),

              child: RichText(
                text: TextSpan(
                  style: FontSystem.KR20EB.copyWith(color: Color(0xFF000000)), // 기본 스타일
                  children: <TextSpan>[
                    TextSpan(text: '만나서 반가워요, '),
                    TextSpan(
                      text: "예비 반려인",
                      style: TextStyle(color: Color(0xFF634EC0)), //
                    ),
                    TextSpan(text: '님! 🐾'),
                  ],
                ),
              )
            ),

            Container(
              padding: const EdgeInsets.only(right: 16),
              child: Image.asset(
                "assets/images/home/profile.png",
                width: 32,
                height: 32,
              ),
            ),

          ],
        ),
        SizedBox(height: Get.height * 0.030),
      ],
    );
  }
}

class _Middle extends StatelessWidget {
  const _Middle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 30, right: 16),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                "assets/images/home/foot.svg",
                height: 20,
              ),
              Text("오늘 만날 친구는?",
                style: FontSystem.KR16B,),
            ],
          ),
          SvgPicture.asset(
            "assets/images/home/sort.svg",
            height: 35,
          ),
        ],
      ),
    );
  }
}

class _DogList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final HomeViewModel viewModel = Get.put(HomeViewModel());

    return Expanded(
      child: Container(
        margin:  EdgeInsets.only(left: 24, right: 24),
        child: PagedGridView<int, DogList>(

          pagingController: viewModel.pagingController,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1 / 1.2,
            crossAxisSpacing: 0,
            mainAxisSpacing: 0,
          ),
          builderDelegate: PagedChildBuilderDelegate<DogList>(
            itemBuilder: (context, item, index) => Container(
              padding: EdgeInsets.all(0), // 컨테이너 내부 패딩
              child: _DogComponent(
                item: item,
              ),
            ),
          ),
        ),
      ),
    );
  }
  const _DogList({super.key});
}

class _DogComponent extends StatelessWidget {
  const _DogComponent({super.key, required this.item});
  final DogList item;

  @override
  Widget build(BuildContext context) {
    final HomeViewModel viewModel = Get.put(HomeViewModel());
    final DogInfoViewModel dogInfoViewModel = Get.put(DogInfoViewModel());
    final RootViewModel rootViewModel = Get.put(RootViewModel());
    final LikeViewModel likeViewModel = Get.put(LikeViewModel());
    return Material(
      color: Colors.transparent,
      child: Column(
        children: [
          InkWell(
            onTap: () async {
              await UserPreferences.setPostId(item.id.toString());
              await dogInfoViewModel.fetchPage(item.id);
              rootViewModel.changeIndex(4);
            },
            child: Ink(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                image: DecorationImage(
                  image: NetworkImage(item.imagePath), // 이미지 URL
                  fit: BoxFit.fill, // 이미지가 컨테이너를 꽉 채우도록
                ),
              ),
              height: Get.height * 0.15,
              width: Get.width * 0.39,
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 15),
            height: Get.height * 0.07,
            width: Get.width * 0.39,
            decoration: BoxDecoration(
              color: Color(0xFFF0EFF4),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.name, style: FontSystem.KR12B,),
                      Text("${item.age} | ${item.type}",
                      style: FontSystem.KR8R,),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    // print("Heart icon tapped!");
                    likeViewModel.toggleLike(item.id);
                  },
                  child: Obx(() => SvgPicture.asset(
                    likeViewModel.dogLikeStatus[item.id]?.value ?? false // 여기의 좋아요 상태 변수
                        ? "assets/images/home/heart_fill.svg"
                        : "assets/images/home/heart.svg",
                    height: 15,
                  ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
