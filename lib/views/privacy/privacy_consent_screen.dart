import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bommeong/views/base/base_screen.dart';
import 'package:bommeong/utilities/font_system.dart';
import 'package:get/get.dart';
import '../../viewModels/privacy/privacy_viewmodel.dart';
import 'adoption_screen.dart';
import 'hand_sign_screen.dart';

final isAgreed_1 = false.obs;
final signatureData = Rx<File?>(null);

class PrivacyConsentScreen extends BaseScreen<PrivacyViewModel> {
  const PrivacyConsentScreen({super.key});

  @override
  Widget buildBody(BuildContext context) {
    final PrivacyViewModel viewModel = Get.put(PrivacyViewModel());

    return SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: _Header(),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: _Question(),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: _Body(),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: _Checkbox(),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: _Signature(),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: _Completebutton(),
                ),
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
        Row(
          mainAxisAlignment: MainAxisAlignment.center, // 중앙으로 정렬
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
      crossAxisAlignment: CrossAxisAlignment.start, // 왼쪽으로 정렬
      children: [
        Container(
          padding: EdgeInsets.all(20), // 텍스트에 패딩 추가
          width: MediaQuery.of(context).size.width - 40,
          child: RichText(
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
        ),
      ],
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // 추가된 부분
      children: [
        Container(
          padding: EdgeInsets.all(20), // 텍스트에 패딩 추가
          width: MediaQuery.of(context).size.width - 40,
          decoration: BoxDecoration(
            color: Colors.white, // 배경을 흰색으로 변경
            borderRadius: BorderRadius.circular(10), // 모서리 곡률 10
            border: Border.all(
              color: Color(0xFFCCB7F7), // 가장자리에 스트로크 추가
              width: 1, // 스트로크 너비 설정
            ),
          ),
          child: RichText(
            text: TextSpan(
              children: [
                WidgetSpan(
                  child: Icon(Icons.check, size: 15.0, color: Color(0xFFCCB7F7)), // 체크 표시 아이콘 추가
                ),
                TextSpan(
                  text: '  [필수] 개인 정보 동의서 본문 확인', style: FontSystem.KR15M.copyWith(color: Colors.black),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 30),
        Text(
          '❶ 수집 · 조회 이용 목적 유기견입양신청 및 유기견입양심사와 관련하여 개인정보를 수집·조회 이용\n\n'
              '❷ 수집 · 조회 · 이용 항목 : 생년월일, 성명, 주소, 전화번호, 유기견과의 대화내역, 유기견입양신청서\n\n'
              '❸ 개인정보 보유 및 이용기간 신청일로부터 5년 <보유기간 경과시 파기>\n\n'
              '❹ 동의하지 않을 권리 및 미동의시 불이익 귀하는 본건 유기견입양 및 입양심사와 관련하여 귀하의 개인정보 수집 · 조회 · 이용에 대하여 거부할 권리가 있으며, 동의를 거부할 경우(입양 심사 결과 등)의 불이익을 받을 수 있습니다.\n\n'
              '위 개인정보의 수집 조회 이용과 같은 내용으로 개인정보를 처리하고 있습니다.\n\n'
              '귀하로부터 취득한 개인정보는 개인정보보호법 제 15조, 제17조, 제18조, 제23조 및 제24조에서 정하는 바에 따라 처리 목적 이외에는 사용되지 않으며 변경 시에는 사전 동의를 구할 것입니다.',
          style: FontSystem.KR16M.copyWith(color: Colors.black),
        ),
      ],
    );
  }
}

class _Checkbox extends StatelessWidget {
  _Checkbox({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              '위 항목에 모두 동의합니다',
              style: FontSystem.KR18B.copyWith(color: Colors.black),
            ),
            InkWell(
              onTap: () {
                isAgreed_1.value = !isAgreed_1.value;
              },
              child: Obx(() => Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isAgreed_1.value ? Color(0xFFCCB7F7) : Colors.white,
                  border: Border.all(color: Color(0xFFCCB7F7), width: 1),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: isAgreed_1.value
                      ? Icon(Icons.check, size: 20.0, color: Colors.white)
                      : Icon(Icons.check, size: 20.0, color: Color(0xFFCCB7F7)),
                ),
              )),
            ),
          ],
        ),
      ],
    );
  }
}

class _Signature extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          // Todo: 서명 다시하면 해당 서명으로 업데이터 해야됨
          onTap: () async {
            // 서명 페이지로 이동하고 File로 서명 결과를 받아옴
            final File? result = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SignaturePage()),
            );
            if (result != null) {
              signatureData.value = result;
              // viewModel.updateUploadFile(result); // viewModel 사용 시
            }
          },
          child: Obx(() => Container(
            width: MediaQuery.of(context).size.width - 60, // 좌우 여백 30을 고려한 너비
            height: 150, // 서명 컨테이너의 높이
            decoration: BoxDecoration(
              color: Colors.white, // 회색 배경
              borderRadius: BorderRadius.circular(10), // 둥근 모서리
              border: Border.all(
                color: Color(0xFFCCB7F7), // 가장자리에 스트로크 추가
                width: 1, // 스트로크 너비 설정
              ),
            ),
            child: Center(
              child: signatureData.value != null
                  ? Image.file(signatureData.value!) // File 객체를 직접 사용
                  : Text('클릭해서 서명하세요', style: FontSystem.KR18B.copyWith(color: Colors.black)), // 서명 전 문구
            ),
          )),
        ),
      ],
    );
  }
}

class _Completebutton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width - 40, // 핸드폰 가로 너비에서 40(양쪽 20씩)을 뺀 값
          height: 50,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: isAgreed_1.value && signatureData.value != null ? Color(0xFFA273FF) : Color(0xFFCBB9F0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10), // 곡률을 10으로 설정
              ),
            ),
            onPressed: isAgreed_1.value && signatureData.value != null
                ? () {
              Get.to(() => AdoptionScreen());
            }
                : null, // 조건이 충족되지 않으면 버튼 비활성화
            child: Text(
              '입양 신청서 작성하기',
              style: FontSystem.KR16B.copyWith(color: Colors.white),
            ),
          ),
        ),
      ],
    ));
  }
}