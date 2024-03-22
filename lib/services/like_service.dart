import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:bommeong/models/like/like_state.dart';

class LikeService {
  Future<bool> toggleLike(LikeRequest request) async {
    var url = Uri.parse('${dotenv.env['BOM_API']}/post/like');
    var response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(request.toJson()),
    );

    if (response.statusCode == 200) {
      print("좋아요 갔습니다.");
      return true;

    } else {
      // 에러 처리
      print('Failed to toggle like');
      return false;
    }
  }
}
