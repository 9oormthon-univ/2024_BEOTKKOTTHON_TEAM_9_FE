import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bommeong/viewModels/home/home_viewmodel.dart';
import 'package:bommeong/views/base/base_screen.dart';
import 'package:flutter_svg/svg.dart';
import 'package:bommeong/utilities/font_system.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:bommeong/models/home/doglist_state.dart';
import 'package:bommeong/services/user_service.dart';
import 'package:bommeong/viewModels/home/home_viewmodel.dart';


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

              child: Text("만나서 반가워요, 현정님!",
              style: FontSystem.KR20EB.copyWith(color: Color(0xFF000000)),),
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
      child: PagedGridView<int, DogList>(
        pagingController: viewModel.pagingController,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 한 줄에 2개의 항목을 표시
          childAspectRatio: 1 / 1.2, // 항목의 가로세로 비율 조정
          crossAxisSpacing: 10, // 항목 간의 가로 간격
          mainAxisSpacing: 10, // 항목 간의 세로 간격
        ),
        builderDelegate: PagedChildBuilderDelegate<DogList>(
          itemBuilder: (context, item, index) => Container(
            padding: EdgeInsets.all(8), // 컨테이너 내부 패딩
            child: Column(
              children: [
                Expanded(
                  child: Image.network(
                    item.imagePath, // 이미지 URL
                    fit: BoxFit.cover, // 이미지가 컨테이너를 꽉 채우도록
                  ),
                ),
                SizedBox(height: 8), // 이미지와 텍스트 사이의 간격
                Text(item.name, // 이름 표시
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ),
      ),
    );

  }
}
