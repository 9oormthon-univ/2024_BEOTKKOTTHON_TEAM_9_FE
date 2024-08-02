import 'dart:io';
import 'package:bommeong/services/userpreferences_service.dart';
import 'package:bommeong/views/home/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart' as path;
import 'package:shared_preferences/shared_preferences.dart';
import '../main_app.dart';
import '../models/privacy/privacy_state.dart';
import '../utilities/app_routes.dart';
import '../viewModels/root/root_viewmodel.dart';
import '../views/root/root_screen.dart';

class PrivacyService {

  // void restartApp() {
  //   Get.offAll(() => MainApp(initialRoute: Routes.HOME),
  //       transition: Transition.fade);
  //   Get.reset();
  // }

  Future<bool> submitAnnouncement(Post post) async {
    try {
      // 환경 변수에서 API URL 가져오기
      String? baseAPI = dotenv.env['API'];
      String? postpageAPI = "$baseAPI/adopt";

      // 사용자의 토큰 가져오기
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('access_token');

      if (token == null || token.isEmpty) {
        throw Exception('Privacy: No access token available');
      }

      var uri = Uri.parse(postpageAPI!);
      var request = http.MultipartRequest('POST', uri);

      // 필드 설정
      request.fields.addAll({
        'postId': post.postId,
        'memberId': post.memberId,
        'adoptApplication.petHistoryAnswer': post.adoptApplication.petHistoryAnswer,
        'adoptApplication.petHistory': post.adoptApplication.petHistory,
        'adoptApplication.currentPetAnswer': post.adoptApplication.currentPetAnswer,
        'adoptApplication.currentPet': post.adoptApplication.currentPet,
        'adoptApplication.familyAnswer': post.adoptApplication.familyAnswer,
        'adoptApplication.familyAgreement': post.adoptApplication.familyAgreement,
        'adoptApplication.reasonForAdoption': post.adoptApplication.reasonForAdoption,
        'adoptApplication.dogNewsAnswer': post.adoptApplication.dogNewsAnswer,
      });

      // 파일 업로드 처리
      if (post.uploadFile != null && post.uploadFile!.existsSync()) {
        // 파일의 MIME 타입 자동 탐지
        final mimeType = _lookupMimeType(post.uploadFile!.path);
        // 파일 추가
        request.files.add(await http.MultipartFile.fromPath(
          'uploadFile',
          post.uploadFile!.path,
          contentType: MediaType('image', mimeType),
        ));
      } else {
        print('파일이 없거나 경로가 잘못되었습니다.');
      }

      // 헤더 추가
      request.headers.addAll({
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      });

      // 요청 데이터 확인
      _printRequestData(request);

      // 요청 보내기
      final response = await request.send();
      final respStr = await response.stream.bytesToString();

      // 응답 처리
      if (response.statusCode == 200) {
      //   WidgetsBinding.instance.addPostFrameCallback((_) {
      //     restartApp();
      //   });

        RootViewModel rootViewModel = Get.put(RootViewModel());
        Get.offAll(() => RootScreen());
        rootViewModel.changeIndex(0);


        await UserPreferences.setDogId("YES");
        return true;
      } else {
        print('Failed to submit announcement');
        print('Status Code: ${response.statusCode}');
        print('Response Body: $respStr');
        return false;
      }
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }

  // 파일의 MIME 타입을 결정하는 함수
  String _lookupMimeType(String filePath) {
    final extension = path.extension(filePath).toLowerCase();
    switch (extension) {
      case '.jpg':
      case '.jpeg':
        return 'jpeg';
      case '.png':
        return 'png';
      case '.gif':
        return 'gif';
      default:
        return 'jpeg'; // 기본 값
    }
  }

  // 요청 데이터 출력 함수
  void _printRequestData(http.MultipartRequest request) {
    print("=== 요청 데이터 시작 ===");
    print("Fields:");
    request.fields.forEach((key, value) {
      print("$key: $value");
    });

    print("Files:");
    for (var file in request.files) {
      print("Field Name: ${file.field}");
      print("File Name: ${file.filename}");
      print("Content Type: ${file.contentType}");
      print("Length: ${file.length}");
    }

    print("=== 요청 데이터 끝 ===");
  }
}
