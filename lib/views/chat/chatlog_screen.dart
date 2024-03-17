import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import '../../utilities/font_system.dart';
import '../../viewModels/login/login_viewmodel.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: ChatlogScreen(),
    );
  }
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
                padding: const EdgeInsets.only(left: 30),

                child: RichText(
                  text: TextSpan(
                    style: FontSystem.KR20EB.copyWith(color: Color(0xFF000000)), // 기본 스타일
                    children: <TextSpan>[
                      TextSpan(text: '만나서 반가워요, '),
                      TextSpan(
                        text: '예비보호자',
                        style: TextStyle(color: Color(0xFF634EC0)), // '예비보호자' 부분에만 적용할 스타일
                      ),
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

class ChatlogScreen extends StatelessWidget {
  final viewModel = LoginViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40), // 전체적인 좌우 패딩 추가
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(flex: 1), // 상단 공간
              SvgPicture.asset(
                "assets/images/chat/dog.svg",
                height: 30,
              ),
              SizedBox(height: 10),
              Text(
                '아직 대화기록이 없어요\n\n봄멍에선 유기견의 페르소나와\n대화할 수 있습니다.',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(flex: 1), // 상단 공간

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFFA273FF),
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {

                },
                child: Text(
                  '랜덤으로 강아지와 얘기해보기!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 30), // 하단 공간
            ],
          ),
        ),
      ),
    );
  }
}
