import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ButtonContainer_1 extends StatefulWidget {
  @override
  _ButtonContainer_1State createState() => _ButtonContainer_1State();
}

class _ButtonContainer_1State extends State<ButtonContainer_1> {
  double _opacity = 0.0; // 초기 투명도를 0으로 설정하여 위젯이 보이지 않게 함

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        _opacity = 1.0; // 3초 후에 투명도를 1로 변경하여 위젯이 서서히 나타나게 함
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _opacity, // 위젯의 투명도
      duration: Duration(seconds: 1), // 투명도 변경 애니메이션 지속 시간
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width - 40,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color(0xFFFF8787),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {},
              child: Text(
                '예',
                style: TextStyle(
                  fontSize: 16.0,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          SizedBox(height: 20),

          Container(
            width: MediaQuery.of(context).size.width - 40,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color(0xFFFF8787),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {},
              child: Text(
                '아니오',
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
