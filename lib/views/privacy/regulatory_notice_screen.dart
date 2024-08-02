import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bommeong/views/base/base_screen.dart';
import 'package:bommeong/utilities/font_system.dart';
import 'package:get/get.dart';
import '../../viewModels/privacy/privacy_viewmodel.dart';
import '../../viewModels/root/root_viewmodel.dart';

final QuestionNum = 0.obs;
final allYes = false.obs;
final selectedOptions = List.generate(4, (_) => ''.obs);

class RegulatoryNoticeScreen extends BaseScreen<PrivacyViewModel> {
  const RegulatoryNoticeScreen({super.key});

  @override
  Widget buildBody(BuildContext context) {
    final PrivacyViewModel viewModel = Get.put(PrivacyViewModel());

    return Obx(() => SingleChildScrollView(
      child: Container(
        color: QuestionNum.value == 0 ? Colors.white : Color(0xFFFAFAFA),
        child: Column(
          children: [
            _Header(),
            if (QuestionNum.value == 0)
              _StartWidget()
            else ...[
              _ShowNoticeWidget(),
              SizedBox(height: 50),
              _SubmissionButton(),
              SizedBox(height: 75),
            ],
          ],
        ),
      ),
    ));
  }

  @override
  bool get wrapWithOuterSafeArea => true;

  @override
  bool get wrapWithInnerSafeArea => true;
}

class _Header extends StatelessWidget {
  _Header({super.key});
  double screenheight = Get.height;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: screenheight * 0.055,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: RichText(
                  text: TextSpan(
                    style: FontSystem.KR20EB.copyWith(color: Color(0xFF000000)),
                    children: <TextSpan>[
                      TextSpan(text: '입양 규정 고지'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StartWidget extends StatelessWidget {
  const _StartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _buildQuestion(context),
        SizedBox(height: Get.height * 0.7),
        Positioned(
          bottom: 0,
          child: _buildStartButton(context),
        ),
      ],
    );
  }

  Widget _buildQuestion(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      width: MediaQuery.of(context).size.width - 40,
      child: RichText(
        text: TextSpan(
          style: FontSystem.KR35SB.copyWith(color: Colors.black),
          children: <TextSpan>[
            TextSpan(text: '이제 정말\n'),
            TextSpan(
              text: '마지막 절차',
              style: FontSystem.KR35SB.copyWith(color: Color(0xFFA273FF)),
            ),
            TextSpan(text: '만\n남았어요'),
          ],
        ),
      ),
    );
  }

  Widget _buildStartButton(BuildContext context) {
    return Container(
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
    );
  }
}

class _ShowNoticeWidget extends StatelessWidget {
  const _ShowNoticeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildQuestionContainer(
            context,
            '반려 동물이 자연사할 때까지 곁을 지켜주실 수 있습니까?',
            '네',
            '아니요',
            ['자연사할'],
            '때까지',
            0
        ),
        _buildQuestionContainer(
            context,
            '입양하신 후 끝까지 책임지고 키우실 수 있습니까?',
            '네',
            '아니요',
            ['끝까지', '책임지고'],
            '책임지고',
            1
        ),
        _buildQuestionContainer(
            context,
            '반려 동물의 불임 수술 시행에 동의하십니까?',
            '네',
            '아니요',
            ['불임', '수술', '시행에'],
            '시행에',
            2
        ),
        _buildQuestionContainer(
            context,
            '입양 시 반려 동물에 대한 책임비 납부에 동의하십니까?',
            '네',
            '아니요',
            ['책임비', '납부에'],
            '대한',
            3
        ),
      ],
    );
  }

  Widget _buildQuestionContainer(BuildContext context, String question, String option1, String option2, List<String> obsKeys, String breakAfter, int index) {
    final words = question.split(' ');
    final breakAfterIndex = words.indexOf(breakAfter);

    List<TextSpan> spans = [];
    for (int i = 0; i < words.length; i++) {
      if (obsKeys.contains(words[i])) {
        spans.add(TextSpan(
          text: words[i] + ' ',
          style: FontSystem.KR15M.copyWith(color: Color(0xFFA273FF)),
        ));
      } else {
        spans.add(TextSpan(text: words[i] + ' '));
      }
      if (i == breakAfterIndex) {
        spans.add(TextSpan(text: '\n'));
      }
    }

    return Container(
      padding: EdgeInsets.fromLTRB(0, 50, 0, 50),
      margin: EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: FontSystem.KR15M.copyWith(color: Colors.black),
              children: spans,
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(() => Checkbox(
                value: selectedOptions[index].value == option1,
                onChanged: (value) {
                  selectedOptions[index].value = value == true ? option1 : '';
                  checkAllYes();
                },
                side: BorderSide(color: Color(0xFFA273FF)),
                activeColor: Color(0xFFA273FF),
              )),
              Text(
                option1,
                style: FontSystem.KR15M.copyWith(color: Colors.black),
              ),
              SizedBox(width: 20),
              Obx(() => Checkbox(
                value: selectedOptions[index].value == option2,
                onChanged: (value) {
                  selectedOptions[index].value = value == true ? option2 : '';
                  checkAllYes();
                },
                side: BorderSide(color: Color(0xFFA273FF)),
                activeColor: Color(0xFFA273FF),
              )),
              Text(
                option2,
                style: FontSystem.KR15M.copyWith(color: Colors.black),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void checkAllYes() {
    allYes.value = selectedOptions.every((option) => option.value == '네');
  }
}

class _SubmissionButton extends StatelessWidget {
  _SubmissionButton({super.key});
  final PrivacyViewModel viewModel = Get.put(PrivacyViewModel());
  RootViewModel rootViewModel = Get.put(RootViewModel());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width - 40,
          height: 60,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: allYes.value ? Color(0xFFA273FF) : Color(0xFFD9D9D9),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: allYes.value
                ? () async {
              bool success = await viewModel.attemptPost();
              if (success) {
                RootViewModel rootViewModel = Get.put(RootViewModel());
                rootViewModel.changeIndex(0);
              } else {
                Get.snackbar(
                  'Error',
                  'Failed to submit the application.',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.red,
                  colorText: Colors.white,
                );
              }
            }
                : null,
            child: Text(
              '신청서 제출하기',
              style: FontSystem.KR16B.copyWith(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    ));
  }
}