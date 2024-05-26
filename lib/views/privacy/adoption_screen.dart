import 'dart:io';
import 'package:bommeong/viewModels/home/doginfo_viewmodel.dart';
import 'package:bommeong/viewModels/message/message_viewmodel.dart';
import 'package:bommeong/viewModels/root/root_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bommeong/views/base/base_screen.dart';
import 'package:bommeong/utilities/font_system.dart';
import 'package:get/get.dart';
import '../../viewModels/privacy/privacy_viewmodel.dart';
import 'hand_sign_screen.dart';

class AdoptionScreen extends BaseScreen<PrivacyViewModel> {
  const AdoptionScreen({super.key});

  @override
  Widget buildBody(BuildContext context) {
    final PrivacyViewModel viewModel = Get.put(PrivacyViewModel());

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0), // 모든 방향에 대해 20의 패딩 적용
        child: Column(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0), // Header 위젯에 패딩 적용
                  child: _Header(),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0), // Question 위젯에 패딩 적용
                  child: _Question(),
                ),
              ],
            ),
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

class _Header extends StatelessWidget {
  const _Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                child: RichText(
                  text: TextSpan(
                    style: FontSystem.KR20EB.copyWith(color: Color(0xFF000000)), // 기본 스타일
                    children: <TextSpan>[
                      TextSpan(text: '개인 정보 동의'),
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

class _Question extends StatelessWidget {
  const _Question({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // 추가된 부분
      children: [
        RichText(
          text: TextSpan(
            style: FontSystem.KR20B.copyWith(color: Colors.black),
            children: <TextSpan>[
              TextSpan(text: '입양을 결심해주셔서\n감사합니다\n\n더 안전한 입양을 위해\n아래 내용을\n'),
              TextSpan(
                text: '확인',
                style: TextStyle(color: Color(0xFFCCB7F7)),
              ),
              TextSpan(text: '해주세요'),
            ],
          ),
        ),
        // 여기에 다른 위젯들을 추가할 수 있습니다.
      ],
    );
  }
}