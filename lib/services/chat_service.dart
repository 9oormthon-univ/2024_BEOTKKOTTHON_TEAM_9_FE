import 'dart:convert';

import 'package:bommeong/models/home/dog_state.dart';
import 'package:bommeong/providers/AuthController.dart';
import 'package:bommeong/viewModels/chat/chat_viewmodel.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:bommeong/viewModels/home/doginfo_viewmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'userpreferences_service.dart';

class GetChatList {
  Future<List<ChatList>> fetchItems(int pageKey) async {

    String? mainpageAPI = '${dotenv.env['API']}/chat/${UserPreferences.getMemberId()}';
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');

    if (token == null || token.isEmpty) {
      throw Exception('Chat : No access token available');
    }

    final response = await http.get(
      Uri.parse(mainpageAPI),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      String responseBody = utf8.decode(response.bodyBytes);
      return processResponse(responseBody);
    } else {
      throw Exception('Failed to load items');
    }
  }
}

List<ChatList> processResponse(String responseBody) {
  List<ChatList> chatlists = [];
  Map<String, dynamic> decodedResponse = json.decode(responseBody);
  List<dynamic> results = decodedResponse['result'];

  for (var item in results) {
    print(item['imageUrl']);
    print(item['name']);
    print(item['status']);
    print(item['date']);
    chatlists.add(ChatList(
      imagePath: item['imageUrl'],
      name: item['name'],
      status: item['status'] == 'before' ? '아직 친구를 기다리고있어요!' : '좋은친구와 함께하게 됐어요!🎉', //?
      date: item['date'] == null ? DateTime.now() : DateTime.parse(item['date']),
    ));
  }

  print(chatlists);

  ChatViewModel chatViewModel = Get.put(ChatViewModel());
  if(chatlists.length == 0) chatViewModel.isHaveChat.value = false;
  else chatViewModel.isHaveChat.value = true;

  return chatlists;
}


class GetGPTChat {
  Future<String> fetchItems(String input) async {
    DogInfoViewModel dogInfoViewModel = Get.put(DogInfoViewModel());

    int PostId = dogInfoViewModel.dogId.value;
    UserPreferences userPreferences = UserPreferences();
    int MemberId = UserPreferences.getMemberId();

    print('PostId: $PostId');
    print('MemberId: $MemberId');

    String? mainpageAPI = '${dotenv.env['API']}/chat/$PostId/$MemberId';
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');

    if (token == null || token.isEmpty) {
      print('GPT: No access token available');
      throw Exception('GPT: No access token available');
    }

    var data = jsonEncode({
      "input": input,
    });

    print('API URL: $mainpageAPI');
    print('Request body: $data');

    try {
      final response = await http.post(
        Uri.parse(mainpageAPI),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: data,
      );

      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        String responseBody = utf8.decode(response.bodyBytes);
        Map<String, dynamic> decodedResponse = json.decode(responseBody);
        dynamic results = decodedResponse['result'];
        return results['response'];
      } else {
        print('Failed to load items: ${response.statusCode}');
        throw Exception('Failed to load items: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching items: $e');
      throw Exception('Error fetching items: $e');
    }
  }
}
