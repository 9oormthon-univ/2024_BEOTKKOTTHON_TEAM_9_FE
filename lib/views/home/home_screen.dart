import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bommeong/viewModels/home/home_viewmodel.dart';
import 'package:bommeong/views/base/base_screen.dart';
import 'package:flutter_svg/svg.dart';
import 'package:bommeong/utilities/font_system.dart';

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
