import 'package:bommeong/viewModels/home/doginfo_viewmodel.dart';
import 'package:bommeong/viewModels/message/message_viewmodel.dart';
import 'package:bommeong/viewModels/root/root_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bommeong/views/base/base_screen.dart';
import 'package:bommeong/utilities/font_system.dart';
import 'package:get/get.dart';
import '../../viewModels/privacy/privacy_viewmodel.dart';

class PrivacyConsentScreen extends BaseScreen<PrivacyViewModel> {
  const PrivacyConsentScreen({super.key});

  @override
  Widget buildBody(BuildContext context) {
    final PrivacyViewModel viewModel = Get.put(PrivacyViewModel());

    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 16),
          Stack(
            children: [
              _Header(),


            ],
          ),

        ],
      ),
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