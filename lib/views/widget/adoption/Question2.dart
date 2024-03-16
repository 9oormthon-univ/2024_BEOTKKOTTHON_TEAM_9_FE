import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../main_app.dart';
import '../../../utilities/app_routes.dart';
import '../../home/home_screen.dart';
import '../controller/responses_controller.dart';
import '../privacy/privacy_consent_screen.dart';

class QuestionScreen2 extends StatefulWidget {
  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen2> {
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
      _currentWidget = Q1(
        donePressed: () => _showQ1(),
      );
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
              '이제 정말\n마지막 절차만\n남았어요',
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

class Q1 extends StatefulWidget {
  final VoidCallback donePressed;

  Q1({required this.donePressed});

  @override
  _Q1State createState() => _Q1State();
}

class _Q1State extends State<Q1> {
  bool _isCheckedYes_1 = false;
  bool _isCheckedNo_1 = false;
  bool _isCheckedYes_2 = false;
  bool _isCheckedNo_2 = false;
  bool _isCheckedYes_3 = false;
  bool _isCheckedNo_3 = false;
  bool _isCheckedYes_4 = false;
  bool _isCheckedNo_4 = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(20), // 텍스트에 패딩 추가
              width: MediaQuery.of(context).size.width - 40,
              decoration: BoxDecoration(
                color: Colors.grey.shade300, // 회색 배경
                borderRadius: BorderRadius.circular(10), // 모서리 곡률 10
              ),

              // 1번
              child: Text(
                '반려동물이 자연사할 때까지\n곁을 지켜주실 수 있습니까?',
                style: TextStyle(
                  fontSize: 16.0,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center, // 가로축 중앙 정렬
              children: <Widget>[
                Flexible(
                  child: Row(
                    mainAxisSize: MainAxisSize.min, // 최소 공간 사용
                    children: [
                      Checkbox(
                        value: _isCheckedYes_1,
                        onChanged: (bool? value) {
                          setState(() {
                            if(!_isCheckedYes_1) {
                              _isCheckedYes_1 = value!;
                              _isCheckedNo_1 = !value;
                            }
                          });
                        },
                      ),
                      Text('예',
                          style: TextStyle(
                          fontSize: 15.0,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 70,), // 체크박스 사이의 간격
                Flexible(
                  child: Row(
                    mainAxisSize: MainAxisSize.min, // 최소 공간 사용
                    children: [
                      Checkbox(
                        value: _isCheckedNo_1,
                        onChanged: (bool? value) {
                          setState(() {
                            if(!_isCheckedNo_1) {
                              _isCheckedNo_1 = value!;
                              _isCheckedYes_1 = !value;
                            }
                          });
                        },
                      ),
                      Text('아니오',
                          style: TextStyle(
                          fontSize: 15.0,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 30,),

            // 2번
            Container(
              padding: EdgeInsets.all(20), // 텍스트에 패딩 추가
              width: MediaQuery.of(context).size.width - 40,
              decoration: BoxDecoration(
                color: Colors.grey.shade300, // 회색 배경
                borderRadius: BorderRadius.circular(10), // 모서리 곡률 10
              ),

              child: Text(
                '입양하신 후 \n끝까지 책임지고 키우실 수 있습니까?',
                style: TextStyle(
                  fontSize: 16.0,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center, // 가로축 중앙 정렬
              children: <Widget>[
                Flexible(
                  child: Row(
                    mainAxisSize: MainAxisSize.min, // 최소 공간 사용
                    children: [
                      Checkbox(
                        value: _isCheckedYes_2,
                        onChanged: (bool? value) {
                          setState(() {
                            if(!_isCheckedYes_2) {
                              _isCheckedYes_2 = value!;
                              _isCheckedNo_2 = !value;
                            }
                          });
                        },
                      ),
                      Text('예',
                        style: TextStyle(
                          fontSize: 15.0,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 70,), // 체크박스 사이의 간격
                Flexible(
                  child: Row(
                    mainAxisSize: MainAxisSize.min, // 최소 공간 사용
                    children: [
                      Checkbox(
                        value: _isCheckedNo_2,
                        onChanged: (bool? value) {
                          setState(() {
                            if(!_isCheckedNo_2) {
                              _isCheckedNo_2 = value!;
                              _isCheckedYes_2 = !value;
                            }
                          });
                        },
                      ),
                      Text('아니오',
                        style: TextStyle(
                          fontSize: 15.0,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 30,),

            // 3번
            Container(
              padding: EdgeInsets.all(20), // 텍스트에 패딩 추가
              width: MediaQuery.of(context).size.width - 40,
              decoration: BoxDecoration(
                color: Colors.grey.shade300, // 회색 배경
                borderRadius: BorderRadius.circular(10), // 모서리 곡률 10
              ),
              child: Text(
                '반려동물의 불임 수술 시행에 동의하십니까?',
                style: TextStyle(
                  fontSize: 16.0,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center, // 가로축 중앙 정렬
              children: <Widget>[
                Flexible(
                  child: Row(
                    mainAxisSize: MainAxisSize.min, // 최소 공간 사용
                    children: [
                      Checkbox(
                        value: _isCheckedYes_3,
                        onChanged: (bool? value) {
                          setState(() {
                            if(!_isCheckedYes_3) {
                              _isCheckedYes_3 = value!;
                              _isCheckedNo_3 = !value;
                            }
                          });
                        },
                      ),
                      Text('예',
                        style: TextStyle(
                          fontSize: 15.0,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 70,), // 체크박스 사이의 간격
                Flexible(
                  child: Row(
                    mainAxisSize: MainAxisSize.min, // 최소 공간 사용
                    children: [
                      Checkbox(
                        value: _isCheckedNo_3,
                        onChanged: (bool? value) {
                          setState(() {
                            if(!_isCheckedNo_3) {
                              _isCheckedNo_3 = value!;
                              _isCheckedYes_3 = !value;
                            }
                          });
                        },
                      ),
                      Text('아니오',
                        style: TextStyle(
                          fontSize: 15.0,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 30,),

            // 4번
            Container(
              padding: EdgeInsets.all(20), // 텍스트에 패딩 추가
              width: MediaQuery.of(context).size.width - 40,
              decoration: BoxDecoration(
                color: Colors.grey.shade300, // 회색 배경
                borderRadius: BorderRadius.circular(10), // 모서리 곡률 10
              ),
              child: Text(
                '입양 시 반려동물에 대한 책임비 납부에 \n동의하십니까?',
                style: TextStyle(
                  fontSize: 16.0,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center, // 가로축 중앙 정렬
              children: <Widget>[
                Flexible(
                  child: Row(
                    mainAxisSize: MainAxisSize.min, // 최소 공간 사용
                    children: [
                      Checkbox(
                        value: _isCheckedYes_4,
                        onChanged: (bool? value) {
                          setState(() {
                            if(!_isCheckedYes_4) {
                              _isCheckedYes_4 = value!;
                              _isCheckedNo_4 = !value;
                            }
                          });
                        },
                      ),
                      Text('예',
                        style: TextStyle(
                          fontSize: 15.0,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 70,), // 체크박스 사이의 간격
                Flexible(
                  child: Row(
                    mainAxisSize: MainAxisSize.min, // 최소 공간 사용
                    children: [
                      Checkbox(
                        value: _isCheckedNo_4,
                        onChanged: (bool? value) {
                          setState(() {
                            if(!_isCheckedNo_4) {
                              _isCheckedNo_4 = value!;
                              _isCheckedYes_4 = !value;
                            }
                          });
                        },
                      ),
                      Text('아니오',
                        style: TextStyle(
                          fontSize: 15.0,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 30,),

            // 제출 버튼
            Container(
              width: MediaQuery.of(context).size.width - 40,
              height: 50, // 버튼의 높이를 설정, 필요에 따라 조정 가능
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: _isCheckedYes_1 && _isCheckedYes_2 && _isCheckedYes_3 && _isCheckedYes_4 ? Colors.black: Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // 곡률을 10으로 설정
                  ),
                ),
                onPressed: _isCheckedYes_1 && _isCheckedYes_2 && _isCheckedYes_3 && _isCheckedYes_4 ? () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => MainApp(initialRoute: Routes.ROOT)),
                  );
                }
                    : null,
                child: Text('신청서 제출하기',
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
      ),
    );
  }
}


