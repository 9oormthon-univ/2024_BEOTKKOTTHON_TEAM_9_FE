import 'dart:async';
import 'package:flutter/material.dart';

class QuestionScreen extends StatefulWidget {
  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  late Widget _currentWidget;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _currentWidget = QuestionContainer_1(); // 시작 위젯을 QuestionContainer_1으로 설정
    _timer = Timer(Duration(seconds: 3), () {
      setState(() {
        _currentWidget = QuestionContainer_2(); // 3초 후에 위젯을 QuestionContainer_2로 변경
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // 타이머를 취소
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(seconds: 1), // 전환 애니메이션 지속 시간
      child: _currentWidget, // 현재 선택된 위젯을 표시
    );
  }
}

class QuestionContainer_1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Text(
          '몇가지 간단한 질문을\n드리겠습니다\n\n입양 심사에 사용되는\n자료이므로\n성실히 답변 부탁드립니다',
          style: TextStyle(
            fontSize: 20.0,
            fontFamily: 'Inter',
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),]
    );
  }
}

class QuestionContainer_2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Container(
            child: Text(
              'Q.\n반려동물을 키우신\n경험이 있나요?',
              style: TextStyle(
                fontSize: 20.0,
                fontFamily: 'Inter',
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),]
    );
  }
}