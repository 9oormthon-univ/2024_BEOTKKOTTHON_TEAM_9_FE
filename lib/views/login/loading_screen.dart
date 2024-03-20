import 'dart:async';
import 'package:bommeong/viewModels/home/home_viewmodel.dart';
import 'package:bommeong/viewModels/root/root_viewmodel.dart';
import 'package:bommeong/views/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../main_app.dart';
import '../../utilities/app_routes.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  Widget _currentWidget;
  _LoadingScreenState() : _currentWidget = LoadingScreen1();

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      setState(() {
        _currentWidget = LoadingScreen2(onComplete: () {
          if (mounted) {
            //Get.offAll(HomeScreen());
            // 여기에 바텀 네비게이션 달아야됨
            // RootViewModel rootViewModel = Get.put(RootViewModel());
            // rootViewModel.changeIndex(0);
          }
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: AnimatedSwitcher(
        duration: Duration(seconds: 1),
        child: _currentWidget,
      ),
    );
  }
}

class LoadingScreen1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double imageHeight = Get.height * 0.25; // 화면 높이의 25%
    double imageWidth = Get.width * 0.6; // 화면 너비의 60%

    return Column(
      key: ValueKey('L1'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(30),
          child: RichText(
            textAlign: TextAlign.left,
            text: TextSpan(
              style: TextStyle(
                fontSize: 22.0,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              children: <TextSpan>[
                TextSpan(text: '반가워요, ', style: TextStyle(fontSize: 24.0)),
                TextSpan(text: '현정', style: TextStyle(fontSize: 24.0, color: Color(0xFFA273FF))),
                TextSpan(text: ' 님\n\n', style: TextStyle(fontSize: 24.0)),
                TextSpan(text: '봄 ━━ 멍', style: TextStyle(color: Color(0xFFA273FF))),
                TextSpan(text: '은\n유기견의 페르소나와\n대화할 수 있는 곳이에요'),
              ],
            ),
          ),
        ),
        Spacer(),
        Center(child: SvgPicture.asset("assets/images/login/dog.svg", height: imageHeight, width: imageWidth)),
        Spacer(),
      ],
    );
  }
}

class LoadingScreen2 extends StatefulWidget {
  final Function onComplete;

  LoadingScreen2({required this.onComplete});

  @override
  _LoadingScreen2State createState() => _LoadingScreen2State();
}

class _LoadingScreen2State extends State<LoadingScreen2> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 6), () => widget.onComplete());
  }

  @override
  Widget build(BuildContext context) {
    double imageHeight = Get.height * 0.25; // 화면 높이의 25%
    double imageWidth = Get.width * 0.6; // 화면 너비의 60%

    return Container(
      key: ValueKey('L2'),
      padding: EdgeInsets.all(30),
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          RichText(
            textAlign: TextAlign.left,
            text: TextSpan(
              style: TextStyle(fontSize: 24.0, fontFamily: 'Pretendard', fontWeight: FontWeight.w500, color: Colors.black),
              children: <TextSpan>[
                TextSpan(text: '유기견을 관심있게\n보는 당신께\n\n'),
                TextSpan(text: '감사를 전합니다.\n\n', style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Spacer(),
          Center(child: SvgPicture.asset("assets/images/login/dog.svg", height: imageHeight, width: imageWidth)),
          Spacer(),
        ],
      ),
    );
  }
}
