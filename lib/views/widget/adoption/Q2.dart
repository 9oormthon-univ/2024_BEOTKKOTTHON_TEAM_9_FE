import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/responses_controller.dart';

// 상태 관리를 위한 ResponsesController 인스턴스 생성
final ResponsesController responsesController = Get.put(ResponsesController());

class QuestionScreen2 extends StatefulWidget {
  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen2> {
  late Widget _currentWidget;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(Duration(seconds: 1), () {
      setState(() {
        _currentWidget = Q2();
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // Timer가 더 이상 필요하지 않을 때 취소
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(seconds: 1),
      child: _currentWidget,
    );
  }
}

class Q2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      key: ValueKey('Q1'),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Q.\n반려동물을 키우신\n경험이 있나요?',
            textAlign: TextAlign.left, // 왼쪽 정렬 설정
            style: TextStyle(
              fontSize: 20.0,
              fontFamily: 'Inter',
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 50,),
          Container(
            width: MediaQuery.of(context).size.width - 40, // 핸드폰 가로 너비에서 40(양쪽 20씩)을 뺀 값
            height: 50, // 버튼의 높이를 설정, 필요에 따라 조정 가능
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color(0xFFFF7676),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // 곡률을 10으로 설정
                ),
              ),
              onPressed: () {
                responsesController.addResponse({"question1": "Yes"});
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => Q2()));
              },
              child: Text('네',
                style: TextStyle(
                  fontSize: 16.0,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),),
            ),
          ),
          SizedBox(height: 30,),
          Container(
            width: MediaQuery.of(context).size.width - 40, // 핸드폰 가로 너비에서 40(양쪽 20씩)을 뺀 값
            height: 50, // 버튼의 높이를 설정, 필요에 따라 조정 가능
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color(0xFFFF7676),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // 곡률을 10으로 설정
                ),
              ),
              onPressed: () {
                responsesController.addResponse({"question1": "No"});
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => Q2()));
              },
              child: Text('아니오',
                style: TextStyle(
                  fontSize: 16.0,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),),
            ),
          ),
        ],
      ),
    );
  }
}
