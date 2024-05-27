import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bommeong/utilities/font_system.dart';
import 'package:bommeong/views/base/base_screen.dart';
import '../../viewModels/privacy/privacy_viewmodel.dart';

final QuestionNum = 0.obs;

class AdoptionScreen extends BaseScreen<PrivacyViewModel> {
  const AdoptionScreen({super.key});

  @override
  Widget buildBody(BuildContext context) {
    final PrivacyViewModel viewModel = Get.put(PrivacyViewModel());

    return Obx(() => Stack(
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: _Header(),
            ),
            if (QuestionNum.value == 0)
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: _Question(),
              ),
            if (QuestionNum.value == 1)
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: _FirstQuestion(),
              ),
            if (QuestionNum.value == 2)
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: _SecondQuestion(),
              ),
          ],
        ),
        Positioned(
          bottom: 30, // 아래 패딩 30
          left: 0,
          right: 0,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0), // 좌우 패딩 30
            child: QuestionNum.value == 0 ? _StartButton() :
                    QuestionNum.value == 1 ? _FirstButton() :
                     QuestionNum.value == 2 ? _SecondShortAnswer() : _FirstButton(),
          ),
        ),
      ],
    ));
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: RichText(
                text: TextSpan(
                  style: FontSystem.KR20EB.copyWith(color: Color(0xFF000000)),
                  children: <TextSpan>[
                    TextSpan(text: '입양 신청서'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
// 시작
class _Question extends StatelessWidget {
  const _Question({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width - 40,
          child: RichText(
            text: TextSpan(
              style: FontSystem.KR22B.copyWith(color: Colors.black),
              children: <TextSpan>[
                TextSpan(text: '몇가지 '),
                TextSpan(
                  text: '간단한 질문',
                  style: FontSystem.KR22B.copyWith(color: Color(0xFFA273FF)),
                ),
                TextSpan(text: '을\n드리겠습니다\n\n'),
                TextSpan(
                  text: '입양 심사',
                  style: FontSystem.KR22B.copyWith(color: Color(0xFFA273FF)),
                ),
                TextSpan(text: '에 사용되는\n자료이므로\n'),
                TextSpan(
                  text: '성실히 답변',
                  style: FontSystem.KR22B.copyWith(color: Color(0xFFA273FF)),
                ),
                TextSpan(text: ' 부탁드립니다'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
// 1
class _FirstQuestion extends StatelessWidget {
  const _FirstQuestion({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width - 40,
          child: RichText(
            text: TextSpan(
              style: FontSystem.KR22B.copyWith(color: Colors.black),
              children: <TextSpan>[
                TextSpan(text: 'Q.\n'),
                TextSpan(
                  text: '반려 동물',
                  style: FontSystem.KR22B.copyWith(color: Color(0xFFA273FF)),
                ),
                TextSpan(text: '을\n키우신 '),
                TextSpan(
                  text: '경험',
                  style: FontSystem.KR22B.copyWith(color: Color(0xFFA273FF)),
                ),
                TextSpan(text: '이 있습니까?'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
// 2
class _SecondQuestion extends StatelessWidget {
  const _SecondQuestion({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width - 40,
          child: RichText(
            text: TextSpan(
              style: FontSystem.KR22B.copyWith(color: Colors.black),
              children: <TextSpan>[
                TextSpan(text: 'Q.\n'),
                TextSpan(
                  text: '어떤 종류',
                  style: FontSystem.KR22B.copyWith(color: Color(0xFFA273FF)),
                ),
                TextSpan(text: '의 동물을\n'),
                TextSpan(
                  text: '얼마나',
                  style: FontSystem.KR22B.copyWith(color: Color(0xFFA273FF)),
                ),
                TextSpan(text: ' 키웠나요?'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}


// 0 -> 1(시작)
class _StartButton extends StatelessWidget {
  const _StartButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width - 40,
          height: 50,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFA273FF),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {
              QuestionNum.value = 1;
            },
            child: Text(
              '확인했습니다',
              style: FontSystem.KR16B.copyWith(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
// 1 -> 2(예) or 1 -> 3(아니오)
class _FirstButton extends StatelessWidget {
  const _FirstButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width - 40,
          height: 50,
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              backgroundColor: Colors.white,
              side: BorderSide(color: Color(0xFFA273FF)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {
              QuestionNum.value = 2;
            },
            child: Text(
              '네, 있습니다.',
              style: FontSystem.KR16B.copyWith(
                color: Colors.black,
              ),
            ),
          ),
        ),
        SizedBox(height: 30),
        Container(
          width: MediaQuery.of(context).size.width - 40,
          height: 50,
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              backgroundColor: Colors.white,
              side: BorderSide(color: Color(0xFFA273FF)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {
              QuestionNum.value = 3;
            },
            child: Text(
              '아니오, 없습니다.',
              style: FontSystem.KR16B.copyWith(
                color: Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
// 2(주관식)
class _SecondShortAnswer extends StatelessWidget {
  const _SecondShortAnswer({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = TextEditingController();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 450,
          decoration: BoxDecoration(
            color: Colors.white, // 배경을 흰색으로 변경
            borderRadius: BorderRadius.circular(10), // 모서리 곡률 10
            border: Border.all(
              color: Color(0xFFCCB7F7), // 가장자리에 스트로크 추가
              width: 1, // 스트로크 너비 설정
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: TextField(
            controller: _controller, // 사용자 입력을 추적하는 컨트롤러 추가
            maxLines: null, // 무제한 줄 입력 가능
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "클릭하여 작성해주세요.",
            ),
          ),
        ),
        SizedBox(height: 30),
        Container(
          width: MediaQuery.of(context).size.width - 40,
          height: 50,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFA273FF),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {
              // viewModel.thirdResponse.value = _controller.text;
              QuestionNum.value = 4;
            },
            child: Text(
              '작성 완료',
              style: FontSystem.KR16B.copyWith(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}