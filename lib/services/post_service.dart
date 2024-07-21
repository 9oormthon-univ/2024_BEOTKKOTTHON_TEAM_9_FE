import 'dart:convert';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart' as path;
import 'package:get/get.dart';
import '../providers/AuthController.dart';

class PostService {
  Future<bool> submitAnnouncement(String postId, String name, String character, String extra, String age, String breed, String gender, String like, String hate, String fd, File? dp) async {
    String? postpageAPI = dotenv.env['postpageAPI'];
    var uri = Uri.parse(postpageAPI!);

    var request = http.MultipartRequest('POST', uri);

    request.fields['shelterId'] = postId;
    request.fields['bomInfo.name'] = name;
    request.fields['bomInfo.age'] = age;
    request.fields['bomInfo.gender'] = gender;
    request.fields['bomInfo.breed'] = breed;
    request.fields['bomInfo.personality'] = character;
    request.fields['bomInfo.extra'] = extra;
    request.fields['bomInfo.likes'] = like;
    request.fields['bomInfo.hates'] = hate;
    request.fields['bomInfo.findingLocation'] = fd;


    if (dp != null) {
      request.files.add(await http.MultipartFile.fromPath(
        'uploadFile',
        dp!.path,
        contentType: MediaType('image', path.extension(dp!.path).substring(1)),
      ));
    }

    final response = await request.send();
    final respStr = await response.stream.bytesToString();
    print(respStr);

    if (response.statusCode == 200) {
      print('Announcement submitted successfully');
      return true;
    } else {
      print('Failed to submit announcement');
      return false;
    }
  }
}
