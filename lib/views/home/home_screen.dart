import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bommeong/viewModels/home/home_viewmodel.dart';
import 'package:bommeong/views/base/base_screen.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreen extends BaseScreen<HomeViewModel> {
  const HomeScreen({super.key});

  @override
  Widget buildBody(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: SvgPicture.asset(
            "assets/images/home/BOMMEONG.svg",
            height: 16,
          ),
        ),
        _Header(),
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
        Text("처음 오셨네요!"),
        Row(
          children: [
            Text("만나서 반가워요, 현정님!"),
            Image.asset(
              "assets/images/home/profile.png",
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
    return Row(
      children: [
        SvgPicture.asset(
          "assets/images/home/foot.svg",
          height: 16,
        ),
        Text("오늘 만날 친구는?"),
        SvgPicture.asset(
          "assets/images/home/sort.svg",
          height: 16,
        ),
      ],
    );
  }
}
