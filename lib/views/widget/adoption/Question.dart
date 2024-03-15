import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/responses_controller.dart';

// 상태 관리를 위한 ResponsesController 인스턴스 생성
final ResponsesController responsesController = Get.put(ResponsesController());

class QuestionScreen extends StatefulWidget {
  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  // 초기 위젯을 Q()로 설정하고, 필요에 따라 업데이트
  Widget _currentWidget;
  _QuestionScreenState() : _currentWidget = Q();

  @override
  void initState() {
    super.initState();
    // 3초 후에 Q1을 보여주도록 설정
    Future.delayed(Duration(seconds: 3), () {
      _showQ1();
    });
  }

  void _showQ1() {
    setState(() {
      // Q1 인스턴스 생성 시 콜백 함수를 전달
      _currentWidget = Q1(
        onYesPressed: () => _showQ2(),
        onNoPressed: () => _showQ2(),
      );
    });
  }

  void _showQ2() {
    setState(() {
      _currentWidget = Q2(
        allPressed: () => _showQ3(),
        somePressed: () => _showQ3(),
        nonePressed: () => _showQ3(),
      );
    });
  }

  void _showQ3() {
    setState(() {
      _currentWidget = Q3(
        donePressed: () => _showQ4(),
      );
    });
  }

  void _showQ4() {
    setState(() {
      _currentWidget = Q4();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(seconds: 1),
      child: _currentWidget,
    );
  }
}

class Q extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      key: ValueKey('Q'),
      child: Column(
        children: [
          Text(
            '몇가지 간단한 질문을\n드리겠습니다\n\n입양 심사에 사용되는\n자료이므로\n성실히 답변 부탁드립니다',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 20.0,
              fontFamily: 'Inter',
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ]
      ),
    );
  }
}

class Q1 extends StatelessWidget {
  late final VoidCallback onYesPressed;
  late final VoidCallback onNoPressed;

  Q1({required this.onYesPressed, required this.onNoPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: ValueKey('Q1'),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Q.1\n반려동물을 키우신\n경험이 있나요?',
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
                onYesPressed();
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
                onNoPressed();
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

class Q2 extends StatelessWidget {
  late final VoidCallback allPressed;
  late final VoidCallback somePressed;
  late final VoidCallback nonePressed;

  Q2({required this.allPressed, required this.somePressed, required this.nonePressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: ValueKey('Q2'),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Q.2\n가족 구성원들은\n유기동물 입양\n찬성하시나요?',
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
                responsesController.addResponse({"question2": "모두 찬성"});
                allPressed();
              },
              child: Text('모두 찬성',
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
                responsesController.addResponse({"question2": "부분 찬성"});
                somePressed();
              },
              child: Text('부분 찬성',
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
                responsesController.addResponse({"question2": "모두 반대"});
                nonePressed();
              },
              child: Text('모두 반대',
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

class Q3 extends StatelessWidget {
  final VoidCallback donePressed;
  final TextEditingController _controller = TextEditingController();

  Q3({required this.donePressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: ValueKey('Q3'),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Q.3\n어떤 종류의 동물을\n얼마나 키웠나요?',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 20.0,
              fontFamily: 'Inter',
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 20,),
          Container(
            height: 500,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              controller: _controller, // 사용자 입력을 추적하는 컨트롤러 추가
              maxLines: null, // 무제한 줄 입력 가능
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "여기에 입력하세요...",
              ),
            ),
          ),
          SizedBox(height: 30,),
          Container(
            width: MediaQuery.of(context).size.width - 40,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color(0xFFFF7676),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                // 사용자가 입력한 텍스트를 responsesController에 저장
                responsesController.addResponse({"question3": _controller.text});
                donePressed();
              },
              child: Text('작성 완료',
                style: TextStyle(
                  fontSize: 16.0,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Q4 extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      key: ValueKey('Q4'),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Q.4\n현재 함께 살고 있는\n동물의 종류와 나이\n성별을 작성해주세요',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 20.0,
              fontFamily: 'Inter',
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 20,),
          Container(
            height: 500,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              controller: _controller, // 사용자 입력을 추적하는 컨트롤러 추가
              maxLines: null, // 무제한 줄 입력 가능
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "여기에 입력하세요...",
              ),
            ),
          ),
          SizedBox(height: 30,),
          Container(
            width: MediaQuery.of(context).size.width - 40,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color(0xFFFF7676),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                // 사용자가 입력한 텍스트를 responsesController에 저장
                responsesController.addResponse({"question4": _controller.text});
              },
              child: Text('제출 할게요!',
                style: TextStyle(
                  fontSize: 16.0,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}