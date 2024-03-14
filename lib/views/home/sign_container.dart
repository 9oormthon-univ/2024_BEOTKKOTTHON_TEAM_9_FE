import 'dart:typed_data';
import 'package:flutter/material.dart';

class SignaturePage extends StatefulWidget {
  @override
  _SignaturePageState createState() => _SignaturePageState();
}

class _SignaturePageState extends State<SignaturePage> {
  Uint8List? signatureImage;
  bool signed = false; // 서명이 완료되었는지 여부를 확인하는 플래그입니다.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('서명하기'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (!signed) ...[
              GestureDetector(
                onTap: () async {
                  // 'hand_sign.dart' 파일 내에 있는 서명 페이지로 이동합니다.
                  final Uint8List? result = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HandSignPage()), // 서명 페이지를 열기 위한 가정된 코드
                  );
                  if (result != null) {
                    setState(() {
                      signatureImage = result;
                      signed = true; // 서명 완료 상태를 true로 변경합니다.
                    });
                  }
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(width: 1, color: Colors.grey)),
                  ),
                  child: Text(
                    "클릭해서 서명하세요 (인)",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: 300,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                alignment: Alignment.center,
                child: Text('서명이 여기에 표시됩니다.'),
              ),
            ] else ...[
              // 서명 이미지 표시
              Image.memory(signatureImage!, width: 300, height: 150),
              SizedBox(height: 20),
              Text('서명 완료', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ],
        ),
      ),
    );
  }
}

// 아래는 가정된 서명 위젯입니다. 실제 구현 시 위젯의 내용을 적절히 변경해야 합니다.
class HandSignPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 서명 위젯 구현 내용
    // 사용자가 서명을 완료하면 Uint8List로 서명 이미지를 반환해야 합니다.
    return Container(); // 여기에 실제 서명 위젯을 구현합니다.
  }
}
