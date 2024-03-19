import 'package:bommeong/viewModels/login/signin_viewmodel.dart';
import 'package:bommeong/views/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../utilities/font_system.dart';

class SignInScreen extends StatelessWidget {
  final viewModel = SignInViewModel();
  final String membertype;

  SignInScreen({Key? key, required this.membertype}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    viewModel.membertypeController.text = membertype;

    return Scaffold(
      appBar: AppBar(
        title: Text('회원가입', style: FontSystem.KR20B.copyWith(color: Colors.black),),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30), // 전체적인 좌우 패딩 추가
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(' 아이디', style: FontSystem.KR17SB.copyWith(color: Color(0xFF848484)),),
              SizedBox(height: 12),
              Row(
                children: [
                  CustomTextFormField(
                    controller: viewModel.emailController,
                    hintText: '아이디를 입력해주세요',
                    width: (Get.width - 60 - (Get.width * 0.03)) * 0.65, // 수정: 나머지 공간의 대부분을 사용
                  ),
                  SizedBox(width: Get.width * 0.03), // 필드와 버튼 사이의 간격
                  Container(
                    width: (Get.width - 60 - (Get.width * 0.03)) * 0.35, // 버튼의 너비를 조정
                    child: ElevatedButton(
                      onPressed: () {
                        print("중복 확인 버튼 클릭됨");
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFFA273FF), // 버튼 배경색
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10), // 버튼 모서리 둥글게
                        ),
                      ),
                      child: Text(
                        '중복 확인',
                        style: FontSystem.KR15SB.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 40),
              Text(' 비밀번호', style: FontSystem.KR17SB.copyWith(color: Color(0xFF848484)),),
              SizedBox(height: 12),
              CustomTextFormField(
                controller: viewModel.passwordController,
                hintText: '비밀번호를 입력해주세요',
                obscureText: true, // 비밀번호 입력 필드는 obscureText를 true로 설정
              ),
              SizedBox(height: 13),
              CustomTextFormField(
                controller: viewModel.confirmPasswordController, // 수정된 부분
                hintText: '비밀번호를 다시 입력해주세요',
                obscureText: true,
              ),
              SizedBox(height: 40),
              Text(' 이름', style: FontSystem.KR17SB.copyWith(color: Color(0xFF848484)),),
              SizedBox(height: 12),
              CustomTextFormField(
                controller: viewModel.nameController,
                hintText: '이름을 입력해주세요',
              ),


              SizedBox(height: 40),
              Text(' 휴대폰 번호', style: FontSystem.KR17SB.copyWith(color: Color(0xFF848484)),),
              SizedBox(height: 12),
              CustomTextFormField(
                controller: viewModel.phoneController,
                hintText: '전화번호를 입력해주세요',
              ),
              SizedBox(height: 30),

              // ElevatedButton(
              //   onPressed: () => viewModel.printAllControllerValues(),
              //   style: ElevatedButton.styleFrom(
              //     foregroundColor: Colors.black, backgroundColor: Color(0xFFA273FF),
              //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              //   ),
              //   child: Text('출력값 확인'),
              // ),

              Spacer(flex: 3,),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFA273FF),
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () async {
                  if (viewModel.passwordController.text == viewModel.confirmPasswordController.text) {
                    // 비밀번호가 일치하면 로그인 시도
                    bool isSuccess = await viewModel.attemptSignIn();
                    if (isSuccess) {
                      Get.to(LoginScreen());
                    } else {
                      print("Sign in failed");
                    }
                  } else {
                    print("비밀번호를 알맞게 입력해주세요!");
                  }
                },
                child: Text(
                  '가입 완료',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
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
  final double? width; // 가로 길이를 설정하기 위한 선택적 파라미터

  const CustomTextFormField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.obscureText = false, // 기본값은 false입니다.
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width, // Container의 가로 길이 설정
      height: 45, // Container의 높이를 45로 고정
      child: TextFormField(
        controller: controller,
        obscureText: obscureText, // 비밀번호 필드인 경우 true로 설정
        decoration: InputDecoration(
          hintText: hintText,
          fillColor: Color(0xFFF7F4FF),
          filled: true,
          contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0), // 왼쪽에서 패딩 10만 줌
          hintStyle: TextStyle(
            color: Colors.grey[500],
            fontFamily: 'Pretendard',
            fontWeight: FontWeight.w500,
            fontSize: 15,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          // 높이 조정을 위해 inputBorder의 높이 조정을 제거
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
