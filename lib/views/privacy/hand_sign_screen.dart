import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hand_signature/signature.dart';
import 'package:path_provider/path_provider.dart';
import '../../utilities/font_system.dart';

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

  Future<File?> _saveToFile(ByteData? data) async {
    if (data == null) return null;
    Uint8List bytes = data.buffer.asUint8List();
    String tempPath = (await getTemporaryDirectory()).path;
    String filePath = '$tempPath/signature.png'; // 임시 파일 경로
    File file = File(filePath);
    await file.writeAsBytes(bytes);
    return file;
  }

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
            backgroundColor: Color(0xFFCCB7F7), // 버튼 배경색
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
            final img = await control.toImage(
              color: Colors.black,
              background: Colors.white,
            );
            if (img != null) {
              File? file = await _saveToFile(img); // ByteData를 File로 저장
              if (file != null) Navigator.pop(context, file); // File 반환
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFFCCB7F7), // 버튼 배경색
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