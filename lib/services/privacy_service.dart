import 'dart:convert';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart' as path;
import 'package:get/get.dart';
import '../providers/AuthController.dart';

class PrivacyService {
  Future<bool> submitAnnouncement(
      String firstConsent, String firstResponse, String secondResponse, String thirdResponse, String fourthResponse,
      String firstAdoptionResponse, String secondAdoptionResopnse, File? uploadFile
      )
  async {
    String? postpageAPI = dotenv.env['postpageAPI'];
    var uri = Uri.parse(postpageAPI!);
    var request = http.MultipartRequest('POST', uri);

    // request.fields['postId'] = '1';
    // request.fields['status'] = 'A';
    // request.fields['adoptApplication.firstConsent'] = 'Y';
    // request.fields['adoptApplication.firstResponse'] =
    // request.fields['adoptApplication.secondResponse'] =
    // request.fields['adoptApplication.thirdResponse'] =
    // request.fields['adoptApplication.fourthResponse'] =
    // request.fields['adoptApplication.firstAdoptionResponse'] = 'Y';
    // request.fields['adoptApplication.secondAdoptionResponse'] = 'Y';
    // request.fields['adoptApplication.thirdAdoptionResponse'] = 'Y';
    // request.fields['adoptApplication.fourthAdoptionResponse'] = 'Y';


    // if (dp != null) {
    //   request.files.add(await http.MultipartFile.fromPath(
    //     'uploadFile',
    //     dp!.path,
    //     contentType: MediaType('image', path.extension(dp!.path).substring(1)),
    //   ));
    // }

    final response = await request.send();
    final respStr = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      print('Announcement submitted successfully');
      return true;
    } else {
      print('Failed to submit announcement');
      return false;
    }
  }
}
