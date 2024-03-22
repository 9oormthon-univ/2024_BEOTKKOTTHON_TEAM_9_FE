import 'package:bommeong/viewModels/home/doginfo_viewmodel.dart';
import 'package:bommeong/viewModels/like/like_viewmodel.dart';
import 'package:bommeong/views/home/doginfo_screen.dart';
import 'package:bommeong/views/login/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bommeong/viewModels/home/home_viewmodel.dart';
import 'package:bommeong/views/base/base_screen.dart';
import '../widget/privacy/privacy_consent_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:bommeong/utilities/font_system.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:bommeong/models/home/dog_state.dart';
import 'package:bommeong/services/user_service.dart';
import 'package:bommeong/viewModels/home/home_viewmodel.dart';
import 'package:bommeong/views/home/doginfo_screen.dart';
import 'package:bommeong/viewModels/home/doginfo_viewmodel.dart';
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

class _Header extends StatelessWidget {
  const _Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          //정렬
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(left: 30),
          child: Text("처음 오셨네요!",
          style: FontSystem.KR12B.copyWith(color: Color(0xFF979797)),),
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
                      text: '예비보호자',
                      style: TextStyle(color: Color(0xFF634EC0)), // '예비보호자' 부분에만 적용할 스타일
                    ),
                    TextSpan(text: '님!'),
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
  const _DogList({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeViewModel viewModel = Get.put(HomeViewModel()); // GetX를 사용하여 뷰모델 인스턴스를 생성 및 등록

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
                      style: FontSystem.KR10R,),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    // 여기에 탭했을 때 실행하고 싶은 코드를 작성하세요.
                    print("Heart icon tapped!");
                    //여기에서 해당하는 포스트의 좋아요가 변경되도록
                    likeViewModel.toggleLike(item.id);

                  },
                  child: Obx(() => SvgPicture.asset(
                    likeViewModel.dogLikeStatus[item.id]?.value ?? false // 여기의 좋아요 상태 변수
                        ? "assets/images/home/heart_fill.svg"
                        : "assets/images/home/heart.svg",
                    height: 20,
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

