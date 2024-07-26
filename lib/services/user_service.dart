import 'dart:ffi';
import 'package:bommeong/services/userpreferences_service.dart';
import 'package:bommeong/viewModels/home/home_viewmodel.dart';
import 'package:bommeong/viewModels/login/login_viewmodel.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:bommeong/models/home/dog_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../providers/AuthController.dart';
import 'dart:convert';
import 'package:bommeong/viewModels/like/like_viewmodel.dart';


class GetDogList {
  late final LoginViewModel loginViewModel;
  bool hasFetched = false; // API 호출 여부를 추적하는 변수
  GetDogList(this.loginViewModel);

  Future<List<DogList>> fetchItems(int pageKey) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');

    if (hasFetched) return [];

    String? mainpageAPI = '${dotenv.env['API']}/post';

    if (token == null || token.isEmpty) {
      throw Exception('No access token available');
    }

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
      List<int> postIdList = extractPostIds(responseBody);
      print('멍멍이들: $postIdList');

      UserPreferences.setDogList(postIdList);
      hasFetched = true;
      return processResponse(responseBody);
    } else {
      print('Error response: ${response.statusCode} - ${response.body}');
      throw Exception('Failed to load items');
    }
  }
}

// PostId들 다 가져오는거
List<int> extractPostIds(String jsonResponse) {
  List<int> postIdList = [];
  Map<String, dynamic> parsedResponse = json.decode(jsonResponse);
  List<dynamic> resultList = parsedResponse['result'];
  for (var item in resultList) {
    int postId = item['postId'];
    postIdList.add(postId);
  }
  return postIdList;
}


class GetLikeDogList {
  Future<List<DogList>> fetchItems(int pageKey) async {
    String? likepageAPI = '${dotenv.env['API']}/post/like/${UserPreferences.getMemberId()}';
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');
    // 페이지 당 아이템 수(limit)를 100으로 설정하여 10페이지 분량의 데이터를 한 번에 요청합니다.
    final response = await http.get(
      Uri.parse(likepageAPI),
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
    String? mainpageAPI = '${dotenv.env['API']}/post/${id}';
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');
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
      return dogInfoProcessResponse(responseBody);
    } else {
      throw Exception('Failed to load items');
    }
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
      imagePath: item['imageUrl'],
    ));
  }

  HomeViewModel homeViewModel = Get.put(HomeViewModel());
  if(doglists.length == 0) homeViewModel.isHaveDog.value = false;
  else homeViewModel.isHaveDog.value = true;

  LikeViewModel likeViewModel = Get.put(LikeViewModel());
  likeViewModel.isHaveDog.value = homeViewModel.isHaveDog.value;

  return doglists;
}



DogInfo dogInfoProcessResponse(String responseBody) {
  Map<String, dynamic> decodedResponse = json.decode(responseBody);
  dynamic results= decodedResponse['result'];

  print(results['bomInfo']['infoId']);
  print(results['bomInfo']['name']);
  print(results['bomInfo']['age']);
  print(results['bomInfo']['breed']);
  print(results['bomInfo']['likes']);
  print(results['bomInfo']['extra']);
  print(results['imageUrl']);

  return DogInfo(
    id: results['bomInfo']['infoId'],
    name: results['bomInfo']['name'],
    age: results['bomInfo']['age'],
    type: results['bomInfo']['breed'],
    tags: [results['bomInfo']['likes'], results['bomInfo']['breed']],
    dogTalk: results['bomInfo']['extra'],
    imagePath: results['imageUrl'],
  );
}


