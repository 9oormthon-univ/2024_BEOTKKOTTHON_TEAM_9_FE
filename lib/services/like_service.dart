import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:bommeong/models/like/like_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'userpreferences_service.dart';

class LikeService {
  Future<bool> toggleLike(LikeRequest request) async {
    var url = Uri.parse('${dotenv.env['API']}/post/like');
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');

    if (token == null || token.isEmpty) {
      throw Exception('LikeToggle : No access token available');
    }

    final response = await http.post(
      url,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
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

  Future<List<int>> fetchAllPostIds() async {
    final url = Uri.parse('${dotenv.env['API']}/post/like/${UserPreferences.getMemberId()}');
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');

    if (token == null || token.isEmpty) {
      throw Exception('LikeFetch : No access token available');
    }

    final response = await http.post(
      url,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body)["result"];
      List<int> postIds = body.map<int>((item) => item["postId"] as int).toList();
      return postIds;
    } else {
      throw Exception('Failed to load post IDs');
    }
  }
}