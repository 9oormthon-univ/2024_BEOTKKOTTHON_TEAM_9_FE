import 'package:bommeong/views/login/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utilities/font_system.dart';

class SelectMTScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: HelloWidget(),
    );
  }
}

class HelloWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(40),
          child: RichText(
            textAlign: TextAlign.left,
            text: TextSpan(
              style: TextStyle(
                fontSize: 24.0,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              children: <TextSpan>[
                TextSpan(text: '반가워요!\n\n', style: TextStyle(fontSize: 26.0)),
                TextSpan(text: '봄멍', style: TextStyle(color: Color(0xFFA273FF))),
                TextSpan(text: '엔\n어떤 이유로\n찾아오셨나요?'),
              ],
            ),
          ),
        ),
        Spacer(flex: 2),
        _BottomButton(
          buttonText: '유기견 입양하기',
          backgroundColor: Color(0xFFA273FF),
          onTap: () {
            Get.to(() => SignInScreen(membertype: "B"));
          },
        ),
        SizedBox(height: 20,),
        _BottomButton(
          buttonText: '입양 공고 게시하기',
          backgroundColor: Color(0xFFCCB7F7),
          onTap: () {
            Get.to(() => SignInScreen(membertype: "S"));
          },
        ),
        SizedBox(height: 50,),
      ],
    );
  }
}


class _BottomButton extends StatelessWidget {
  final String buttonText;
  final Color backgroundColor;
  final VoidCallback onTap;

  _BottomButton({
    required this.buttonText,
    required this.backgroundColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: onTap, // onTap 콜백 사용
        child: Container(
          width: Get.width * 0.85,
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
          decoration: BoxDecoration(
            color: backgroundColor, // 배경색 설정
            borderRadius: BorderRadius.circular(10), // 모서리 둥글기 반경 설정
          ),
          child: Text(
            buttonText, // 버튼 텍스트
            style: FontSystem.KR16B.copyWith(color: Colors.white),
            textAlign: TextAlign.center, // 텍스트 정렬
          ),
        ),
      ),
    );
  }
}
