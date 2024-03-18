import 'package:bommeong/views/login/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:intl/date_symbol_data_file.dart';
import '../../viewModels/login/login_viewmodel.dart';

void main() async {
  /* Open .env file */
  await dotenv.load(fileName: "assets/config/.env");

  // Splash Screen Duration 1.0s
  await Future.delayed(const Duration(seconds: 1));

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatelessWidget {
  final viewModel = LoginViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40), // 전체적인 좌우 패딩 추가
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Spacer(flex: 2), // 상단 공간
              SvgPicture.asset(
                "assets/images/login/foot.svg",
                height: 30,
              ),
              SizedBox(height: 10),
              Text(
                '봄멍으로!',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 40),
              // 아이디 입력 필드
              TextFormField(
                controller: viewModel.emailController, // 추가: 컨트롤러 연결
                decoration: InputDecoration(
                  hintText: '아이디를 입력해주세요',
                  fillColor: Color(0xFFF7F4FF),
                  filled: true,
                  hintStyle: TextStyle(
                    color: Colors.grey[500],
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 20), // 입력 필드 간격
              // 비밀번호 입력 필드
              TextFormField(
                controller: viewModel.passwordController, // 추가: 컨트롤러 연결
                obscureText: true,
                decoration: InputDecoration(
                  hintText: '비밀번호를 입력해주세요',
                  fillColor: Color(0xFFF7F4FF),
                  filled: true,
                  hintStyle: TextStyle(
                    color: Colors.grey[500],
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 30),
              // 로그인 버튼 필드
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFA273FF),
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () async {
                  bool isSuccess = await viewModel.attemptLogIn();
                  if (isSuccess) {
                    Get.to(LoadingScreen());
                  } else {
                    // 실패 했을 시에
                  }
                },
                child: Text(
                  '로그인',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 10),
              // 밑 비밀번호 찾기 및 회원가입
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly, // 변경: 정렬을 spaceEvenly로
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        '비밀번호 찾기',
                        textAlign: TextAlign.right, // 오른쪽 정렬
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      '|',
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Pretendard',
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        '회원가입',
                        textAlign: TextAlign.left, // 왼쪽 정렬
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Spacer(flex: 3), // 하단 공간
            ],
          ),
        ),
      ),
    );
  }
}
