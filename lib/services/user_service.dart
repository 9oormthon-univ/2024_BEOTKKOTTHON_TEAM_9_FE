import 'dart:ffi';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:bommeong/models/home/dog_state.dart';
import '../providers/AuthController.dart';
import 'dart:convert';
import 'package:bommeong/viewModels/like/like_viewmodel.dart';


class GetDogList {
  Future<List<DogList>> fetchItems(int pageKey) async {
    String? mainpageAPI = dotenv.env['mainpageAPI'];
    var token = Get.find<AuthController>().token; // AuthController에서 token 가져오기

    // 페이지 당 아이템 수(limit)를 100으로 설정하여 10페이지 분량의 데이터를 한 번에 요청합니다.
    final response = await http.get(
      Uri.parse('$mainpageAPI?page=$pageKey&limit=10'),
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

class GetLikeDogList {

  Future<List<DogList>> fetchItems(int pageKey) async {
    String? likepageAPI = dotenv.env['mainpageAPI'];
    var token = Get.find<AuthController>().token;

    // 페이지 당 아이템 수(limit)를 100으로 설정하여 10페이지 분량의 데이터를 한 번에 요청합니다.
    final response = await http.get(
      Uri.parse('$likepageAPI?page=$pageKey&limit=10'),
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

class GetDogInfo {
  Future<DogInfo> fetchItems(int id) async {
    // API 대신 사용할 더미 데이터
    await Future.delayed(Duration(seconds: 1)); // 네트워크 요청을 흉내내기 위한 딜레이

    return DogInfo(
      id: id,
      name: 'Dog #$id',
      age: 'old',
      type: (id % 2 == 0) ? 'Labrador' : 'Beagle',
      favourite: false, // 기본값
      tags: ['tag1', 'tag2', 'tag3'],
      dogTalk: '멍멍입니다. 멍멍할 예정입니다.',
      imagePath: 'https://ifh.cc/g/tBmzjl.jpg',
    );
  }
}

class GetChatList {
  Future<List<ChatList>> fetchItems(int pageKey) async {
    // 네트워크 요청을 흉내내기 위한 딜레이
    await Future.delayed(Duration(seconds: 1));

    // 더미 데이터 생성
    List<ChatList> items = List.generate(10, (index) {
      int id = pageKey * 10 + index;
      return ChatList(
        imagePath: 'https://ifh.cc/g/tBmzjl.jpg', // 가상의 이미지 경로
        name: 'Chat Partner #$id',
        status: id % 2 == 0
            ? '아직 친구를 기다리고있어요!'
            : '좋은친구와 함께하게 됐어요!🎉', // 간단한 조건으로 상태를 정함
        date: DateTime.now().subtract(Duration(days: id)), // 현재로부터 id일 전의 날짜
      );
    });

    return items;
  }

}

class AuthService extends GetxService {
  // 이 예제에서는 간단하게 로그인 상태를 bool로 관리합니다.
  // 실제 앱에서는 로컬 저장소에서 로그인 토큰의 존재 여부를 확인해야 합니다.
  bool _isLoggedIn = false; // 기본값은 false로 설정

  bool get isLoggedIn => _isLoggedIn;

  // 로그인 상태를 변경하는 함수 (로그인 시)
  void login() {
    _isLoggedIn = true;
    update();
  }

  // 로그아웃 함수 (로그아웃 시)
  void logout() {
    _isLoggedIn = false;
    update();
  }

  void update() {}
}


List<DogList> processResponse(String responseBody) {
  List<DogList> doglists = [];
  Map<String, dynamic> decodedResponse = json.decode(responseBody);
  List<dynamic> results = decodedResponse['result'];

  for (var item in results) {
    Map<String, dynamic> bomInfo = item['bomInfo'];
    doglists.add(DogList(
      id: bomInfo['infoId'],
      name:bomInfo['name'],
      age: bomInfo['age'],
      type: bomInfo['breed'],
      favourite: false, // 기본값
      imagePath: item['imageUrl'],
    ));
  }

  LikeViewModel likeViewModel = Get.put(LikeViewModel());
  if(doglists.length == 0) likeViewModel.isHaveDog.value = false;
  else likeViewModel.isHaveDog.value = true;

  return doglists;
}