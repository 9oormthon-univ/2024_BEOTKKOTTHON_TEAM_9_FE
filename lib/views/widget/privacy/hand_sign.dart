import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:hand_signature/signature.dart';

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
          Expanded(
            child: Center(
              child: AspectRatio(
                aspectRatio: 2.0,
                child: HandSignature(
                  control: control,
                  color: Colors.black,
                  width: 1.0,
                  type: SignatureDrawType.shape,
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
      ElevatedButton(
        onPressed: () {
          control.clear();
          rawImage.value = null;
        },
        child: Text('Clear'),
      ),
      ElevatedButton(
        onPressed: () async {
          // 서명을 이미지로 변환
          final img = await control.toImage(
            color: Colors.black,
            background: Colors.white,
          );

          // ByteData를 Uint8List로 변환하여 저장
          if (img != null) {
            rawImage.value = img; // ByteData 저장
            // ByteData를 Uint8List로 변환하여 다른 화면으로 넘김
            Navigator.pop(context, img.buffer.asUint8List());
          }
        },
        child: Text('Save to PNG'),
      ),
    ],
  );

  Widget _buildImageView() => Expanded(
    child: ValueListenableBuilder<ByteData?>(
      valueListenable: rawImage,
      builder: (context, data, child) {
        if (data == null) {
          return Center(child: Text('Sign to display PNG'));
        } else {
          return Center(
            child: Image.memory(data.buffer.asUint8List()),
          );
        }
      },
    ),
  );
}