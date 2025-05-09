// signin_screen.dart
import 'package:bommeong/viewModels/login/signin_viewmodel.dart';
import 'package:bommeong/views/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utilities/font_system.dart';

class SignInScreen extends StatelessWidget {
  final viewModel = SignInViewModel();
  final String membertype;
  final String email;
  final String name;
  final String phone;

  SignInScreen({
    Key? key,
    required this.membertype,
    this.email = '',
    this.name = '',
    this.phone = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    viewModel.membertypeController.text = membertype;
    viewModel.emailController.text = email;
    viewModel.nameController.text = name;
    viewModel.phoneController.text = phone;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          '회원가입',
          style: FontSystem.KR20B.copyWith(color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            height: Get.height,
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ' 아이디',
                    style: FontSystem.KR17SB.copyWith(color: Color(0xFF848484)),
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      CustomTextFormField(
                        controller: viewModel.emailController,
                        hintText: '아이디를 입력해주세요',
                        width: (Get.width - 60 - (Get.width * 0.03)) * 0.65,
                      ),
                      SizedBox(width: Get.width * 0.03), // 필드와 버튼 사이의 간격
                      Container(
                        width: (Get.width - 60 - (Get.width * 0.03)) * 0.35,
                        child: ElevatedButton(
                          onPressed: () async {
                            bool isSuccess = await viewModel.checkEmail(viewModel.emailController.text);
                            if(isSuccess) {
                              Get.snackbar(
                                '중복되는 로그인이 없습니다 🐾',
                                '이어서 회원가입을 진행해 주세요!',
                                snackPosition: SnackPosition.TOP,
                                backgroundColor: Color(0xFFA273FF),
                                colorText: Colors.white,
                              );
                            } else {
                              Get.snackbar(
                                '중복되는 아이디가 있어요! 🐾',
                                '다른 아이디를 입력해주세요.',
                                snackPosition: SnackPosition.TOP,
                                backgroundColor: Colors.red,
                                colorText: Colors.white,
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFA273FF), // 버튼 배경색
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10), // 버튼 모서리 둥글게
                            ),
                          ),
                          child: Text(
                            '중복 확인',
                            style: FontSystem.KR14SB.copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 40),
                  Text(
                    ' 비밀번호',
                    style: FontSystem.KR17SB.copyWith(color: Color(0xFF848484)),
                  ),
                  SizedBox(height: 12),
                  CustomTextFormField(
                    controller: viewModel.passwordController,
                    hintText: '비밀번호를 입력해주세요',
                    obscureText: true, // 비밀번호 입력 필드는 obscureText를 true로 설정
                  ),
                  SizedBox(height: 13),
                  CustomTextFormField(
                    controller: viewModel.confirmPasswordController,
                    hintText: '비밀번호를 다시 입력해주세요',
                    obscureText: true,
                  ),
                  SizedBox(height: 40),
                  Text(
                    ' 이름',
                    style: FontSystem.KR17SB.copyWith(color: Color(0xFF848484)),
                  ),
                  SizedBox(height: 12),
                  CustomTextFormField(
                    controller: viewModel.nameController,
                    hintText: '이름을 입력해주세요',
                  ),
                  SizedBox(height: 40),
                  Text(
                    ' 휴대폰 번호',
                    style: FontSystem.KR17SB.copyWith(color: Color(0xFF848484)),
                  ),
                  SizedBox(height: 12),
                  CustomTextFormField(
                    controller: viewModel.phoneController,
                    hintText: '전화번호를 입력해주세요',
                  ),
                  SizedBox(height: 50),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFA273FF),
                      minimumSize: Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () async {
                      if (viewModel.passwordController.text ==
                          viewModel.confirmPasswordController.text) {
                        bool isSuccess = await viewModel.attemptSignIn();
                        if (isSuccess) {
                          Get.snackbar(
                            '회원가입에 감사드립니다 🐾',
                            '가입하신 이메일과 비밀번호로 로그인 해주세요!',
                            snackPosition: SnackPosition.TOP,
                            backgroundColor: Color(0xFFA273FF),
                            colorText: Colors.white,
                          );
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
                      style: FontSystem.KR20B.copyWith(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
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
  final double? width;

  const CustomTextFormField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.obscureText = false,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 45,
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hintText,
          fillColor: Color(0xFFF7F7F7),
          filled: true,
          contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
          hintStyle: FontSystem.KR15R.copyWith(color: Color(0xFFC6C6C6)),
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