import 'dart:convert';

import 'package:bommeong/models/home/dog_state.dart';
import 'package:bommeong/providers/AuthController.dart';
import 'package:bommeong/viewModels/chat/chat_viewmodel.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:bommeong/viewModels/home/doginfo_viewmodel.dart';
import 'userpreferences_service.dart';

class GetChatList {
  Future<List<ChatList>> fetchItems(int pageKey) async {

    String? mainpageAPI = '${dotenv.env['BOM_API']}/chat/${Get.find<AuthController>().memberIdValue}'; //일단 이걸로


    final response = await http.get(
      Uri.parse('$mainpageAPI?page=$pageKey&limit=10'),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
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
    int MemberId = UserPreferences.getUserID();



    print(PostId);
    print(MemberId);


    String? mainpageAPI = '${dotenv.env['BOM_API']}/chat/${PostId}/${MemberId}'; //일단 이걸로

    var data = jsonEncode({
      "input": input,
    });


    final response = await http.post(
      Uri.parse(mainpageAPI),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: data,
    );

    if (response.statusCode == 200) {
      String responseBody = utf8.decode(response.bodyBytes);
      Map<String, dynamic> decodedResponse = json.decode(responseBody);
      dynamic results = decodedResponse['result'];
      return results['response'];

    } else {
      throw Exception('Failed to load items');
    }
  }

}