import 'dart:io';
import 'dart:typed_data';
import 'package:bommeong/viewModels/privacy/privacy_viewmodel.dart';
import 'package:bommeong/views/widget/adoption/Question.dart';
import 'package:flutter/material.dart';
import 'package:hand_signature/signature.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../utilities/font_system.dart';
import 'hand_sign.dart';
import '../adoption/Question2.dart';


class OnboardingScreen extends StatefulWidget {
  final int currentPage;
  OnboardingScreen(this.currentPage);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late final PageController _controller;
  final viewModel = PrivacyViewModel();

  int _currentPage = 0;
  bool isAgreed_1 = false;
  bool isSigned_1 = false;
  Uint8List? signatureData;
  double _opacity = 0.0;

  final signcontroller = HandSignatureControl(
    threshold: 5.0,
    smoothRatio: 0.65,
    velocityRange: 2.0,
  );

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: widget.currentPage);
    _currentPage = widget.currentPage;
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        _opacity = 1.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 앱바는 건드릴거 X
      appBar: AppBar(
        title: Text(
          _currentPage == 0 ? '개인 정보 동의' : (_currentPage == 1 ? '입양 신청서' : '입양 규정 고지'), style: FontSystem.KR20B.copyWith(color: Colors.black)
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: <Widget>[
          Container(
            padding: EdgeInsets.only(right: 30.0),
            child: Center(
              child: SmoothPageIndicator(
                controller: _controller,
                count: 3,
                effect: WormEffect(
                  dotHeight: 10,
                  dotWidth: 10,
                  spacing: 5,
                  activeDotColor: Colors.red,
                ),
                onDotClicked: (index) {
                  _controller.animateToPage(
                    index,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                },
              ),
            ),
          ),
        ],
      ),

      body: PageView.builder(
        controller: _controller,
        onPageChanged: (int page) {
          setState(() {
            _currentPage = page;
          });
        },
        itemBuilder: (context, index) {
          if (index == 0) {
            // 스크롤
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                    SizedBox(height: 40),


                    // 개인 정보 동의서 본문 확인
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

                    // Todo: PDF 본문 내용 줘야됨
                    Text(
                      '봄멍조아!봄멍조아!봄멍조아!봄멍조아!봄멍조아!봄멍조아!봄멍조아!봄멍조아!봄멍조아!봄멍조아!봄멍조아!봄멍조아!'
                          '봄멍조아!봄멍조아!봄멍조아!봄멍조아!봄멍조아!봄멍조아!봄멍조아!봄멍조아!봄멍조아!봄멍조아!봄멍조아!봄멍조아!'
                          '봄멍조아!봄멍조아!봄멍조아!봄멍조아!봄멍조아!봄멍조아!봄멍조아!봄멍조아!봄멍조아!봄멍조아!봄멍조아!'
                          '봄멍조아!봄멍조아!봄멍조아!봄멍조아!봄멍조아!봄멍조아!봄멍조아!봄멍조아!봄멍조아!봄멍조아!봄멍조아!봄멍조아!봄멍조아!'
                          '봄멍조아!봄멍조아!봄멍조아!봄멍조아!봄멍조아!봄멍조아!봄멍조아!봄멍조아!봄멍조아!봄멍조아!봄멍조아!봄멍조아!'
                          '봄멍조아!봄멍조아!봄멍조아!봄멍조아!봄멍조아!봄멍조아!봄멍조아!봄멍조아!봄멍조아!봄멍조아!봄멍조아!봄멍조아!봄멍조아!'
                          '봄멍조아!봄멍조아!봄멍조아!봄멍조아!봄멍조아!봄멍조아!봄멍조아!봄멍조아!봄멍조아!봄멍조아!봄멍조아!봄멍조아!봄멍조아!'
                          '봄멍조아!봄멍조아!봄멍조아!봄멍조아!봄멍조아!봄멍조아!봄멍조아!봄멍조아!봄멍조아!봄멍조아!봄멍조아!봄멍조아!봄멍조아!'
                          '봄멍조아!봄멍조아!봄멍조아!봄멍조아!봄멍조아!봄멍조아!봄멍조아!봄멍조아!봄멍조아!봄멍조아!봄멍조아!봄멍조아!봄멍조아!'
                          '봄멍조아!봄멍조아!봄멍조아!봄멍조아!봄멍조아!봄멍조아!봄멍조아!봄멍조아!봄멍조아!봄멍조아!봄멍조아!봄멍조아!봄멍조아!'
                          '봄멍조아!봄멍조아!봄멍조아!봄멍조아!봄멍조아!봄멍조아!봄멍조아!봄멍조아!봄멍조아!봄멍조아!봄멍조아!봄멍조아!봄멍조아!'
                          '',
                      style: FontSystem.KR16M.copyWith(color: Colors.black),
                    ),

                    // Todo: 여기 뷰모델 연동해야됨
                    // 위 항목에 모두 동의합니다 부분.
                    SizedBox(height: 30),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            '위 항목에 모두 동의합니다',
                            style: FontSystem.KR18B.copyWith(color: Colors.black),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                isAgreed_1 = !isAgreed_1;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: isAgreed_1 ? Color(0xFFCCB7F7) : Colors.white,
                                border: Border.all(color: Color(0xFFCCB7F7), width: 1,),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: isAgreed_1
                                    ? Icon(Icons.check, size: 20.0, color: Colors.white,)
                                    : Icon(Icons.check, size: 20.0, color: Color(0xFFCCB7F7),),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),


                    SizedBox(height: 30),
                    // Todo: Uint8List -> File로 바꿔야함
                    // Todo: 서명 페이지 꾸미기..
                    InkWell(
                      onTap: () async {
                        // 서명 페이지로 이동
                        final Uint8List? result = await Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignaturePage()),
                        );
                        if (result != null) {
                          setState(() {
                            signatureData = result; // 서명 데이터 저장
                            // viewModel.updateUploadFile(result as File);
                          });
                        }
                      },
                      child: Container(
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
                          child: signatureData != null
                              ? Image.memory(signatureData!) // 서명 이미지를 보여줍니다
                              : Text('클릭해서 서명하세요', style: FontSystem.KR18B.copyWith(color: Colors.black)), // 서명 전 문구
                        ),
                      ),
                    ),


                    SizedBox(height: 30),
                    Container(
                      width: MediaQuery.of(context).size.width - 40, // 핸드폰 가로 너비에서 40(양쪽 20씩)을 뺀 값
                      height: 50, // 버튼의 높이를 설정, 필요에 따라 조정 가능
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isAgreed_1 && signatureData != null ? Color(0xFFFF7676): Colors.grey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10), // 곡률을 10으로 설정
                          ),
                        ),
                        onPressed: isAgreed_1 && signatureData != null
                            ? () {
                          if (_currentPage < 2) {
                            _controller.nextPage(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeIn,
                            );
                          }
                        } : null, // 조건이 충족되지 않으면 버튼 비활성화
                        child: Text('입양 신청서 작성하기',
                          style: FontSystem.KR16B.copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(height: 50),
                  ],
                ),
              ),
            );
          } else if (index == 1){
            // 다른 페이지의 기본 텍스트 반환
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, // 좌상단으로 정렬하기 위해 start를 설정합니다.
                children: [
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: QuestionScreen(), // 상단 좌측에 정렬될 위젯
                  ),
                  SizedBox(height: 50),
                ],
              ),
            );
          } else if (_currentPage == 2){
            // 다른 페이지의 기본 텍스트 반환
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: QuestionScreen2(), // 상단 좌측에 정렬될 위젯
                  ),
                  SizedBox(height: 50),

                ],
              ),

            );
          }
        },
        physics: NeverScrollableScrollPhysics(),
        itemCount: 3,
      ),
    );
  }
}