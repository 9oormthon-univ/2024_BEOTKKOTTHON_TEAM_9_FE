import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hand_signature/signature.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../home/hand_sign.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;
  bool isAgreed_1 = false;
  bool isSigned_1 = false;
  Uint8List? signatureData;

  final signcontroller = HandSignatureControl(
    threshold: 5.0,
    smoothRatio: 0.65,
    velocityRange: 2.0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _currentPage == 0 ? '개인 정보 동의' : (_currentPage == 1 ? '입양 신청서' : '입양 규정 고지'),
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'Inter',
            color: Colors.black,
          ),
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
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        children: <TextSpan>[
                          TextSpan(text: '입양을 결심해주셔서\n감사합니다\n\n더 안전한 입양을 위해\n아래 내용을\n'),
                          TextSpan(
                            text: '확인',
                            style: TextStyle(color: Color(0xFFFF7676)),
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
                        color: Colors.grey.shade300, // 회색 배경
                        borderRadius: BorderRadius.circular(10), // 모서리 곡률 10
                      ),
                      child: Text(
                        '[필수] 개인 정보 동의서 본문 확인',
                        style: TextStyle(
                          fontSize: 15.0,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(height: 30),

                    // pdf 내용
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
                      style: TextStyle(
                        fontSize: 16.0,
                        fontFamily: 'Inter',
                        color: Colors.black,
                      ),
                    ),

                    // 위 항목에 모두 동의합니다 부분.
                    SizedBox(height: 30),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            '위 항목에 모두 동의합니다',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Checkbox(
                            value: isAgreed_1,
                            onChanged: (bool? value) {
                              setState(() {
                                isAgreed_1 = value!;
                              });
                            },
                          ),
                        ],
                      ),
                    ),


                    SizedBox(height: 30),
                    InkWell(
                      onTap: () async {
                        // 서명 페이지로 이동
                        final Uint8List? result = await Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignaturePage()), // 서명 페이지를 열기 위한 가정된 코드
                        );
                        if (result != null) {
                          setState(() {
                            signatureData = result; // 서명 데이터 저장
                          });
                        }
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width - 60, // 좌우 여백 30을 고려한 너비
                        height: 150, // 서명 컨테이너의 높이
                        decoration: BoxDecoration(
                          color: Colors.grey[300], // 회색 배경
                          borderRadius: BorderRadius.circular(10), // 둥근 모서리
                        ),
                        child: Center(
                          child: signatureData != null
                              ? Image.memory(signatureData!) // 서명 이미지를 보여줍니다
                              : Text('클릭해서 서명하세요', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)), // 서명 전 문구
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            );
          } else {
            // 다른 페이지의 기본 텍스트 반환
            return Center(
              child: Text("페이지 ${index + 1}"),
            );
          }
        },
        itemCount: 3,
      ),
    );
  }
}
