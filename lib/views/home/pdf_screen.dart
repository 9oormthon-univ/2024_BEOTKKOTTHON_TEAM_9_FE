import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'hand_sign.dart'; // 가정한 서명 페이지

class SignatureData {
  Uint8List imageData;
  Offset position;
  int pageNumber; // 서명이 추가된 페이지 번호

  SignatureData({required this.imageData, required this.position, required this.pageNumber});
}

class PDFViewPage extends StatefulWidget {
  @override
  _PDFViewPageState createState() => _PDFViewPageState();
}

class _PDFViewPageState extends State<PDFViewPage> {
  String pdfPath = '';
  List<SignatureData> signatures = [];
  String errorMessage = '';
  bool isLoading = true;
  int currentPage = 0; // 현재 페이지 번호
  bool isScrolling = false; // 스크롤 중인지 여부를 나타내는 상태 변수 추가

  @override
  void initState() {
    super.initState();
    prepareTestPdf().then((path) {
      setState(() {
        pdfPath = path;
        isLoading = false;
      });
    }).catchError((error) {
      setState(() {
        errorMessage = error.toString();
        isLoading = false;
      });
    });
  }

  Future<String> prepareTestPdf() async {
    final ByteData bytes = await rootBundle.load('assets/data/signtest.pdf');
    final Uint8List list = bytes.buffer.asUint8List();
    final tempDir = await getTemporaryDirectory();
    final tempFile = File('${tempDir.path}/signtest.pdf');
    await tempFile.writeAsBytes(list);
    return tempFile.path;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("PDF View")),
      body: Stack(
        children: [
          if (isLoading)
            Center(child: CircularProgressIndicator()),
          if (!isLoading && errorMessage.isEmpty)
            PDFView(
              filePath: pdfPath,
              onPageChanged: (int? page, int? total) {
                setState(() {
                  currentPage = page!;
                });
              },
              onError: (error) {
                setState(() {
                  errorMessage = error.toString();
                });
              },
              onRender: (_) {
                setState(() {
                  isLoading = false;
                });
              },
            ),
          if (!isLoading && errorMessage.isNotEmpty)
            Center(child: Text('PDF 로딩 에러: $errorMessage')),
          ...signatures.where((signature) => signature.pageNumber == currentPage).map((signature) {
            return Positioned(
              left: signature.position.dx,
              top: signature.position.dy,
              child: Draggable(
                data: signature,
                child: Image.memory(signature.imageData, width: 50, height: 50, fit: BoxFit.cover),
                feedback: Material(
                  type: MaterialType.transparency,
                  child: Image.memory(signature.imageData, width: 50, height: 50, fit: BoxFit.cover),
                ),
                childWhenDragging: Container(),
                onDragEnd: (dragDetails) {
                  setState(() {
                    signature.position = Offset(
                      dragDetails.offset.dx,
                      dragDetails.offset.dy - AppBar().preferredSize.height - MediaQuery.of(context).padding.top,
                    );
                  });
                },
              ),
            );
          }).toList(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final Uint8List? result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SignaturePage()), // 서명 페이지 가정
          );
          if (result != null) {
            setState(() {
              signatures.add(SignatureData(imageData: result, position: Offset(50, 50), pageNumber: currentPage));
            });
          }
        },
        tooltip: 'Sign',
        child: Icon(Icons.edit),
      ),
    );
  }
}
