import 'package:bommeong/viewModels/like/like_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:bommeong/views/base/base_screen.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/svg.dart';
import 'package:bommeong/utilities/font_system.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:bommeong/models/home/dog_state.dart';
import 'package:bommeong/services/user_service.dart';
import 'package:bommeong/viewModels/home/home_viewmodel.dart';
import 'package:bommeong/viewModels/home/doginfo_viewmodel.dart';
import 'package:bommeong/viewModels/root/root_viewmodel.dart';


class LikeScreen extends BaseScreen<LikeViewModel> {
  const LikeScreen({super.key});

  @override
  Widget buildBody(BuildContext context) {
    return Column(
      children: [
        _TopImage(),
        SizedBox(height: 22),
        _Header(),
        SizedBox(height: 20),
        viewModel.isHaveDog.value
            ? _DogList()
        : _InitScreen(),

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
        Row(
          children: [
            SizedBox(width: 30),
            SvgPicture.asset(
              "assets/images/home/foot.svg",
              height: 20,
            ),
            SizedBox(width: 5),
            Container(
                child: RichText(
                  text: TextSpan(
                    style: FontSystem.KR20EB.copyWith(color: Color(0xFF000000)), // 기본 스타일
                    children: <TextSpan>[
                      TextSpan(text: '유심히 '),
                      TextSpan(
                        text: '본 - 멍 ',
                        style: TextStyle(color: Color(0xFFA273FF)), // '예비보호자' 부분에만 적용할 스타일
                      ),
                    ],
                  ),
                )
            ),

          ],
        ),
      ],
    );
  }
}

class _TopImage extends StatelessWidget {
  const _TopImage({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: Stack(
        children: [
          Image.asset(
            'assets/images/like/topDog.png',
            width: Get.width,
            height: Get.height* 0.3,
            fit: BoxFit.cover,
          ),
          Align(
            heightFactor: Get.height * 0.002,
            widthFactor: Get.width * 0.0025,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("마음에 담아두셨나요?", style: FontSystem.KR16SB.copyWith(color: Colors.white)),
                Text("다들 아직 기다리고 있어요!", style: FontSystem.KR25EB.copyWith(color: Colors.white)),
              ],
            ),
          )
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
    return Material(
      color: Colors.transparent,
      child: Column(
        children: [
          InkWell(
            onTap: () async {
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
                SvgPicture.asset(
                  item.favourite
                      ? "assets/images/home/heart_fill.svg"
                      : "assets/images/home/heart.svg",
                  height: 20,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InitScreen extends StatelessWidget {
  const _InitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: Get.height * 0.13),
        SvgPicture.asset("assets/images/like/standDog.svg",
            height: Get.height * 0.08),
        SizedBox(height: Get.height * 0.01),

        RichText(
          //정렬
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(
                text: '아직',
                style: FontSystem.KR13M,
              ),
              TextSpan(
                text: ' 마음에 담은\n',
                style: FontSystem.KR13B,
              ),
              TextSpan(
                text: '강아지가 없으시군요!',
                style: FontSystem.KR13M,
              ),
            ],
          ),
        )

      ],
    );
  }
}


