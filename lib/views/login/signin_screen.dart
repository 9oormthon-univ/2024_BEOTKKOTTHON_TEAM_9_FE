import 'package:bommeong/viewModels/login/signin_viewmodel.dart';
import 'package:bommeong/views/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class SignInScreen extends StatelessWidget {
  final viewModel = SignInViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40), // 전체적인 좌우 패딩 추가
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(height: 40),
              CustomTextFormField(
                controller: viewModel.emailController,
                hintText: '아이디를 입력해주세요',
              ),
              SizedBox(height: 20),
              CustomTextFormField(
                controller: viewModel.passwordController,
                hintText: '비밀번호를 입력해주세요',
                obscureText: true, // 비밀번호 입력 필드는 obscureText를 true로 설정
              ),
              SizedBox(height: 20),
              CustomTextFormField(
                controller: viewModel.nameController,
                hintText: '이름를 입력해주세요',
              ),
              SizedBox(height: 20),
              CustomTextFormField(
                controller: viewModel.phoneController,
                hintText: '전화번호를 입력해주세요',
              ),
              SizedBox(height: 30),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // 반려인 버튼
                  ElevatedButton(
                    onPressed: () => viewModel.membertypeController.text = 'B',
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black, backgroundColor: Color(0xFFA273FF),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    child: Text('반려인'),
                  ),
                  SizedBox(width: 20),
                  // 보호소 버튼
                  ElevatedButton(
                    onPressed: () => viewModel.membertypeController.text = 'S',
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black, backgroundColor: Color(0xFFA273FF),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    child: Text('보호소'),
                  ),
                ],
              ),
              SizedBox(height: 20),

              ElevatedButton(
                onPressed: () => viewModel.printAllControllerValues(),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black, backgroundColor: Color(0xFFA273FF),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: Text('출력값 확인'),
              ),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFA273FF),
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () async {
                  bool isSuccess = await viewModel.attemptSignIn();
                  if (isSuccess) {
                    Get.to(LoginScreen());
                  } else {
                    print("Sign in failed");
                  }
                },
                child: Text(
                  '회원가입',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Spacer(flex: 3), // 하단 공간
            ],
          ),
        ),
      ),
    );
  }
}

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;

  const CustomTextFormField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.obscureText = false, // 기본값은 false입니다.
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText, // 비밀번호 필드인 경우 true로 설정합니다.
      decoration: InputDecoration(
        hintText: hintText,
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
    );
  }
}