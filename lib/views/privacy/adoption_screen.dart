import 'package:bommeong/views/privacy/regulatory_notice_screen.dart';
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
        GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: _Header(),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(25, 40, 25, 0),
                child: QuestionNum.value == 0
                    ? _Question()
                    : QuestionNum.value == 1
                    ? _FirstQuestion()
                    : QuestionNum.value == 2
                    ? _SecondQuestion()
                    : QuestionNum.value == 3
                    ? _ThirdQuestion()
                    : QuestionNum.value == 4
                    ? _FourthQuestion()
                    : QuestionNum.value == 5
                    ? _FifthQuestion()
                    : QuestionNum.value == 6
                    ? _SixthQuestion()
                    : QuestionNum.value == 7
                    ? _SeventhQuestion()
                    : _EighthQuestion(),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 30,
          left: 0,
          right: 0,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: QuestionNum.value == 0
                ? _StartButton()
                : QuestionNum.value == 1
                ? _FirstButton()
                : QuestionNum.value == 2
                ? _SecondButton()
                : QuestionNum.value == 3
                ? _ThirdButton()
                : QuestionNum.value == 4
                ? _FourthButton()
                : QuestionNum.value == 5
                ? _FifthButton()
                : QuestionNum.value == 6
                ? _SixthButton()
                : QuestionNum.value == 7
                ? _SeventhButton()
                : _EighthButton(),
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
              style: FontSystem.KR25B.copyWith(color: Colors.black),
              children: <TextSpan>[
                TextSpan(text: 'Q.\n'),
                TextSpan(
                  text: '반려 동물',
                  style: FontSystem.KR25B.copyWith(color: Color(0xFFA273FF)),
                ),
                TextSpan(text: '을\n키우신 '),
                TextSpan(
                  text: '경험',
                  style: FontSystem.KR25B.copyWith(color: Color(0xFFA273FF)),
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
  _SecondQuestion({super.key});
  final PrivacyViewModel viewModel = Get.put(PrivacyViewModel());

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
              style: FontSystem.KR25B.copyWith(color: Colors.black),
              children: <TextSpan>[
                TextSpan(text: 'Q.\n'),
                TextSpan(
                  text: '어떤 종류',
                  style: FontSystem.KR25B.copyWith(color: Color(0xFFA273FF)),
                ),
                TextSpan(text: '의 동물을\n'),
                TextSpan(
                  text: '얼마나',
                  style: FontSystem.KR25B.copyWith(color: Color(0xFFA273FF)),
                ),
                TextSpan(text: ' 키웠나요?'),
              ],
            ),
          ),
        ),
        Container(
          height: 370,
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
            controller: viewModel.setPetHistoryController, // 사용자 입력을 추적하는 컨트롤러 추가
            maxLines: null, // 무제한 줄 입력 가능
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "클릭하여 작성해주세요.",
            ),
          ),
        ),
      ],
    );
  }
}
// 3
class _ThirdQuestion extends StatelessWidget {
  const _ThirdQuestion({super.key});

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
              style: FontSystem.KR25B.copyWith(color: Colors.black),
              children: <TextSpan>[
                TextSpan(text: 'Q.\n'),
                TextSpan(
                  text: '현재 ',
                  style: FontSystem.KR25B.copyWith(color: Color(0xFFA273FF)),
                ),
                TextSpan(text: '집에\n'),
                TextSpan(
                  text: '다른 반려 동물',
                  style: FontSystem.KR25B.copyWith(color: Color(0xFFA273FF)),
                ),
                TextSpan(text: '이\n있습니까?'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
// 4
class _FourthQuestion extends StatelessWidget {
  _FourthQuestion({super.key});
  final PrivacyViewModel viewModel = Get.put(PrivacyViewModel());

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
              style: FontSystem.KR25B.copyWith(color: Colors.black),
              children: <TextSpan>[
                TextSpan(text: 'Q.\n현재 함께 살고 있는\n동물의 '),
                TextSpan(
                  text: '정보 ',
                  style: TextStyle(color: Color(0xFFA273FF)),
                ),
                TextSpan(text: '를 알려주세요\n'),
              ],
            ),
          ),
        ),
        Container(
          height: 370,
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
            controller: viewModel.setCurrentPetController,
            maxLines: null, // 무제한 줄 입력 가능
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "클릭하여 작성해주세요.",
            ),
          ),
        ),
      ],
    );
  }
}
// 5
class _FifthQuestion extends StatelessWidget {
  const _FifthQuestion({super.key});

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
              style: FontSystem.KR25B.copyWith(color: Colors.black),
              children: <TextSpan>[
                TextSpan(text: 'Q.\n현재 '),
                TextSpan(
                  text: '함께 살고 있는\n가족 구성원',
                  style: FontSystem.KR25B.copyWith(color: Color(0xFFA273FF)),
                ),
                TextSpan(text: '이 있나요?\n'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
// 6
class _SixthQuestion extends StatelessWidget {
  const _SixthQuestion({super.key});

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
              style: FontSystem.KR25B.copyWith(color: Colors.black),
              children: <TextSpan>[
                TextSpan(text: 'Q.\n가족 구성원들은\n'),
                TextSpan(
                  text: '유기동물 입양',
                  style: FontSystem.KR25B.copyWith(color: Color(0xFFA273FF)),
                ),
                TextSpan(text: '에\n'),
                TextSpan(
                  text: '찬성 ',
                  style: FontSystem.KR25B.copyWith(color: Color(0xFFA273FF)),
                ),
                TextSpan(text: '하시나요?'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
// 7
class _SeventhQuestion extends StatelessWidget {
  _SeventhQuestion({super.key});
  final PrivacyViewModel viewModel = Get.put(PrivacyViewModel());

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
              style: FontSystem.KR25B.copyWith(color: Colors.black),
              children: <TextSpan>[
                TextSpan(text: 'Q.\n'),
                TextSpan(
                  text: '입양',
                  style: FontSystem.KR25B.copyWith(color: Color(0xFFA273FF)),
                ),
                TextSpan(text: '을 원하는 '),
                TextSpan(
                  text: '이유',
                  style: FontSystem.KR25B.copyWith(color: Color(0xFFA273FF)),
                ),
                TextSpan(text: '는\n무엇인가요?'),
              ],
            ),
          ),
        ),
        Container(
          // Todo : 높이 수정
          height: 370,
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
            controller: viewModel.setReasonForAdoptionController, // 사용자 입력을 추적하는 컨트롤러 추가
            maxLines: null, // 무제한 줄 입력 가능
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "클릭하여 작성해주세요.",
            ),
          ),
        ),
      ],
    );
  }
}
// 8
class _EighthQuestion extends StatelessWidget {
  const _EighthQuestion({super.key});

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
              style: FontSystem.KR25B.copyWith(color: Colors.black),
              children: <TextSpan>[
                TextSpan(text: 'Q.\n'),
                TextSpan(
                  text: '입양 후 ',
                  style: FontSystem.KR25B.copyWith(color: Color(0xFFA273FF)),
                ),
                TextSpan(text: '입양 동물의\n'),
                TextSpan(
                  text: '사진 및 소식',
                  style: FontSystem.KR25B.copyWith(color: Color(0xFFA273FF)),
                ),
                TextSpan(text: '을 전해주실 수\n있으신가요?'),
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
  _FirstButton({super.key});
  final PrivacyViewModel viewModel = Get.put(PrivacyViewModel());

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
              viewModel.setPetHistoryAnswer("YES");
            },
            child: Text(
              '네, 있습니다.',
              style: FontSystem.KR16M.copyWith(
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
              viewModel.setPetHistoryAnswer("NO");
            },
            child: Text(
              '아니오, 없습니다.',
              style: FontSystem.KR16M.copyWith(
                color: Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
// 2(주관식) -> 3
class _SecondButton extends StatelessWidget {
  _SecondButton({super.key});

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
              QuestionNum.value = 3;
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
// 3 -> 4(예) or 3 -> 5(아니오)
class _ThirdButton extends StatelessWidget {
  _ThirdButton({super.key});
  final PrivacyViewModel viewModel = Get.put(PrivacyViewModel());

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
              QuestionNum.value = 4;
              viewModel.setCurrentPetAnswer("YES");
            },
            child: Text(
              '네, 있습니다.',
              style: FontSystem.KR16M.copyWith(
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
              QuestionNum.value = 5;
              viewModel.setCurrentPetAnswer("NO");
            },
            child: Text(
              '아니오, 없습니다.',
              style: FontSystem.KR16M.copyWith(
                color: Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
// 4 -> 5
class _FourthButton extends StatelessWidget {
  const _FourthButton({super.key});

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
              QuestionNum.value = 5;
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
// 5 -> 6(예) or 5 -> 7(아니오)
class _FifthButton extends StatelessWidget {
  _FifthButton({super.key});
  final PrivacyViewModel viewModel = Get.put(PrivacyViewModel());

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
              QuestionNum.value = 6;
              viewModel.setFamilyAnswer("YES");
            },
            child: Text(
              '네, 있습니다.',
              style: FontSystem.KR16M.copyWith(
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
              QuestionNum.value = 7;
              viewModel.setFamilyAnswer("NO");
            },
            child: Text(
              '아니오, 없습니다.',
              style: FontSystem.KR16M.copyWith(
                color: Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
// 6 -> 7
class _SixthButton extends StatelessWidget {
  _SixthButton({super.key});
  final PrivacyViewModel viewModel = Get.put(PrivacyViewModel());

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
              QuestionNum.value = 7;
              viewModel.setFamilyAgreement("AGREE");
            },
            child: Text(
              '모두 찬성',
              style: FontSystem.KR16M.copyWith(
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
              QuestionNum.value = 7;
              viewModel.setFamilyAgreement("PARTIALLY_AGREE");
            },
            child: Text(
              '부분 찬성',
              style: FontSystem.KR16M.copyWith(
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
              QuestionNum.value = 7;
              viewModel.setFamilyAgreement("DISAGREE");
            },
            child: Text(
              '모두 반대',
              style: FontSystem.KR16M.copyWith(
                color: Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
// 7 -> 8
class _SeventhButton extends StatelessWidget {
  const _SeventhButton({super.key});

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
              QuestionNum.value = 8;
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
// 8
class _EighthButton extends StatelessWidget {
  _EighthButton({super.key});
  final PrivacyViewModel viewModel = Get.put(PrivacyViewModel());

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
              viewModel.setDogNewsAnswer("YES");
              Get.to(() => RegulatoryNoticeScreen());
            },
            child: Text(
              '네, 있습니다.',
              style: FontSystem.KR16M.copyWith(
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
              viewModel.setDogNewsAnswer("NO");
              Get.to(() => RegulatoryNoticeScreen());
            },
            child: Text(
              '아니오, 없습니다.',
              style: FontSystem.KR16M.copyWith(
                color: Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}