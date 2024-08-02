import 'package:bommeong/viewModels/root/root_viewmodel.dart';
import 'package:bommeong/views/base/base_screen.dart';
import 'package:bommeong/views/login/loading_screen.dart';
import 'package:bommeong/views/login/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:bommeong/viewModels/login/login_viewmodel.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import '../../utilities/font_system.dart';

class LoginScreen extends BaseScreen<LoginViewModel> {
  const LoginScreen({super.key});

  @override
  Widget buildBody(BuildContext context) {
    final viewModel = LoginViewModel();
    final RootViewModel rootViewModel = Get.find<RootViewModel>();
    double screenheight = Get.height;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(height: screenheight * 0.16),
          SvgPicture.asset(
            "assets/images/login/foot.svg",
            height: Get.height * 0.026,
          ),
          Text(
            '오늘은 봄멍으로!',
            style: FontSystem.KR24B.copyWith(color: Colors.black),
          ),
          SizedBox(height: screenheight * 0.01),

          // 아이디 입력 필드
          TextFormField(
            controller: viewModel.emailController,
            decoration: InputDecoration(
              hintText: '아이디를 입력해주세요',
              fillColor: Color(0xFFF7F4FF),
              filled: true,
              hintStyle: FontSystem.KR17M.copyWith(color: Color(0xFFBCBCBC)),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
          ),

          // 비밀번호 입력 필드
          TextFormField(
            controller: viewModel.passwordController,
            obscureText: true,
            decoration: InputDecoration(
              hintText: '비밀번호를 입력해주세요',
              fillColor: Color(0xFFF7F4FF),
              filled: true,
              hintStyle: FontSystem.KR17M.copyWith(color: Color(0xFFBCBCBC)),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          SizedBox(height: screenheight * 0.005),

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
              try {
                bool isSuccess = await viewModel.attemptLogIn();
                if (isSuccess) {
                  Get.to(LoadingScreen());
                } else {
                  Get.snackbar('로그인 실패', '아이디 또는 비밀번호를 확인해주세요.');
                }
              } catch (e) {
                print('Error during login: $e');
                Get.snackbar('오류', '로그인 중 오류가 발생했습니다.');
              }
            },
            child: Text(
              '로그인',
              style: FontSystem.KR20B.copyWith(color: Colors.white),
            ),
          ),

          // 비밀번호 찾기 및 회원가입
          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceEvenly, // 변경: 정렬을 spaceEvenly로
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    '비밀번호 찾기',
                    textAlign: TextAlign.right, // 오른쪽 정렬
                    style: FontSystem.KR15M.copyWith(color: Color(0xFF9A9A9A)),
                  ),
                ),
              ),
              Text(
                '|',
                style: FontSystem.KR15M.copyWith(color: Color(0xFF9A9A9A)),
              ),
              Expanded(
                child: TextButton(
                  onPressed: () {
                    Get.to(() => SignInScreen(membertype: "B"));
                  },
                  child: Text(
                    '회원가입',
                    textAlign: TextAlign.left, // 왼쪽 정렬
                    style: FontSystem.KR15M.copyWith(color: Color(0xFF9A9A9A)),
                  ),
                ),
              ),
            ],
          ),
          // Todo: 애플 로그인 일단 비활성화
          // SignInWithAppleButton(
          //   onPressed: () => viewModel.signInWithApple(),
          //   style: SignInWithAppleButtonStyle.black,
          // ),
          _sociallogin(),
          SizedBox(height: screenheight * 0.15),
        ],
      ),
    );
  }
}

class _sociallogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final LoginViewModel viewModel = Get.find<LoginViewModel>();

    return Column(
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFFF9E000),
            minimumSize: Size(double.infinity, 44),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: () async {
            await viewModel.loginWithKakao();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/login/kakao.png',
                height: 24,
              ),
              SizedBox(width: 7),
              Text(
                'Sign in with Kakao',
                style: FontSystem.KR20R.copyWith(color: Color(0xFF3C1E1E)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
