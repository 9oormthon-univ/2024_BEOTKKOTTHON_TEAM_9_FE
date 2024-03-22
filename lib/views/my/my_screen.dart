import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bommeong/viewModels/my/my_viewmodel.dart';
import 'package:bommeong/views/base/base_screen.dart';
import 'package:flutter_svg/svg.dart';
import 'package:bommeong/utilities/font_system.dart';
import 'package:get/get.dart';
import 'package:bommeong/viewModels/root/root_viewmodel.dart';

class MyScreen extends BaseScreen<MyViewModel> {
  const MyScreen({super.key});

  @override
  Widget buildBody(BuildContext context) {
    return Column(
      children: [
        _TopPart(),
        Container(
          width: Get.width,
          height: Get.height * 0.02,
          color: Color(0xFFF8F8F8),
        ),
        viewModel.isHaveDog.value
            ? _BottomBox()
            : _InitScreen(),
      ],
    );
  }

  @override
  buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leadingWidth: Get.width,
      leading: Container(
        padding: EdgeInsets.only(
            left: Get.width * 0.03,
            right: Get.width * 0.03,
            bottom: Get.width * 0.03),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("마이페이지", style: FontSystem.KR20B),
          ],
        ),
      ),
    );
  }

  @override
  bool get wrapWithOuterSafeArea => true;

  @override
  bool get wrapWithInnerSafeArea => true;
}

class _TopPart extends StatelessWidget {
  const _TopPart({super.key});

  @override
  Widget build(BuildContext context) {
    MyViewModel myViewModel = Get.put(MyViewModel());
    return Container(
      padding:
          EdgeInsets.only(left: Get.width * 0.05, bottom: Get.width * 0.05),
      child: Row(
        children: [
          Image.asset(
            myViewModel.userImage.value,
            width: Get.width * 0.2,
          ),
          SizedBox(width: Get.width * 0.05),
          Column(
            children: [
              Row(
                children: [
                  Text(myViewModel.userName.value, style: FontSystem.KR25B),
                  SizedBox(width: Get.width * 0.02),
                  Container(
                    height: Get.height * 0.03,
                    width: Get.width * 0.2,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Color(0xFFF4EEFF),
                      borderRadius: BorderRadius.circular(7.5),
                    ),
                    child: Text(myViewModel.membertype.value,
                        style: FontSystem.KR14M
                            .copyWith(color: Color(0xFFA273FF))),
                  ),
                ],
              ),
              Text(myViewModel.useremail.value, style: FontSystem.KR15R),
            ],
          )
        ],
      ),
    );
  }
}

class _BottomBox extends StatelessWidget {
  const _BottomBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: Get.height * 0.02),
        Text("입양 신청 내역", style: FontSystem.KR18B),
        SizedBox(height: Get.height * 0.02),
        _ProgressBar(),
        SizedBox(height: Get.height * 0.02),
        _BottomImg(),
      ],
    );
  }
}

class _ProgressBar extends StatelessWidget {
  const _ProgressBar({super.key});

  @override
  Widget build(BuildContext context) {
    MyViewModel myViewModel = Get.put(MyViewModel());
    return SvgPicture.asset(
      myViewModel.applyAdoption.value,
    );
  }
}

class _BottomImg extends StatelessWidget {
  const _BottomImg({super.key});

  @override
  Widget build(BuildContext context) {
    MyViewModel myViewModel = Get.put(MyViewModel());
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(60.0), // 상단 왼쪽 모서리
        topRight: Radius.circular(60.0), // 상단 오른쪽 모서리
      ),
      child: Stack(
        children: [
          Image.network(
            myViewModel.dogImage.value,
            width: Get.width,
            height: Get.height* 0.48,
            fit: BoxFit.cover,
          ),
          Container(
            width: Get.width,
            height: Get.height* 0.48,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.4),
            ),
          ),
          Align(
            alignment: Alignment.center,
            heightFactor: Get.height * 0.008,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("심사중", style: FontSystem.KR25B.copyWith(color: Colors.white)),
                Text(myViewModel.dogname.value + "를 기다리고 있어요...", style: FontSystem.KR16R.copyWith(color: Colors.white)),
              ],
            ),
          )
        ],
      ),
    );
  }
}


class _InitScreen extends StatelessWidget {
  const _InitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    MyViewModel myViewModel = Get.put(MyViewModel());
    return Column(
      children: [
        SizedBox(height: Get.height * 0.02),
        Text("입양 신청 내역", style: FontSystem.KR18B),
        SizedBox(height: Get.height * 0.2),
        Column(
          children: [
            Image.asset(myViewModel.dogImage.value,
                height: Get.height * 0.08),

            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '기다리고 있는\n친구',
                    style: FontSystem.KR13B,
                  ),
                  TextSpan(
                    text: '들이 많아요!',
                    style: FontSystem.KR13M,
                  ),
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}
