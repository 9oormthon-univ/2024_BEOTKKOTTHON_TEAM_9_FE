import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hand_signature/signature.dart';
import '../../../utilities/font_system.dart';

class SignaturePage extends StatefulWidget {
  @override
  _SignaturePageState createState() => _SignaturePageState();
}

class _SignaturePageState extends State<SignaturePage> {
  final HandSignatureControl control = HandSignatureControl(
    threshold: 0.01,
    smoothRatio: 0.65,
    velocityRange: 2.0,
  );

  ValueNotifier<ByteData?> rawImage = ValueNotifier<ByteData?>(null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("서명하기"),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(20,30,20,0), // 텍스트 주변에 약간의 여백을 추가
            child: Text(
              "서명을 아래 칸에 해주세요",
              style: FontSystem.KR14B.copyWith(color: Colors.grey),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: AspectRatio(
                aspectRatio: 2.0,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Color(0xFFCCB7F7),
                      width: 1,
                    ),
                  ),
                  child: HandSignature(
                    control: control,
                    color: Colors.black,
                    width: 1.0,
                    type: SignatureDrawType.shape,
                  ),
                ),
              ),
            ),
          ),
          _buildControls(),
          _buildImageView(),
        ],
      ),
    );
  }

  Widget _buildControls() => Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: <Widget>[
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), // 컨테이너 곡률
          color: Colors.white, // 컨테이너 배경색
        ),
        child: ElevatedButton(
          onPressed: () {
            control.clear();
            rawImage.value = null;
          },
          style: ElevatedButton.styleFrom(
            primary: Color(0xFFCCB7F7), // 버튼 배경색
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10), // 버튼 곡률
            ),
          ),
          child: Text('지우기', style: FontSystem.KR14B.copyWith(color: Colors.white)),
        ),
      ),
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), // 컨테이너 곡률
          color: Colors.white, // 컨테이너 배경색
        ),
        child: ElevatedButton(
          onPressed: () async {
            // 서명을 이미지로 변환
            final img = await control.toImage(
              color: Colors.black,
              background: Colors.white,
            );
            // ByteData를 Uint8List로 변환하여 저장
            if (img != null) {
              rawImage.value = img; // ByteData 저장
              Navigator.pop(context, img.buffer.asUint8List());
            }
          },
          style: ElevatedButton.styleFrom(
            primary: Color(0xFFCCB7F7), // 버튼 배경색
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10), // 버튼 곡률
            ),
          ),
          child: Text('서명 완료', style: FontSystem.KR14B.copyWith(color: Colors.white)),
        ),
      ),
    ],
  );

  Widget _buildImageView() {
    return Expanded(
      child: Stack(
        children: <Widget>[
          Positioned(
            right: Get.width * 0.05,
            bottom: Get.width * 0.1,
            child: SvgPicture.asset("assets/images/like/standDog.svg", height: Get.width * 0.2, width: Get.width * 0.2),
          ),
        ],
      ),
    );
  }
}