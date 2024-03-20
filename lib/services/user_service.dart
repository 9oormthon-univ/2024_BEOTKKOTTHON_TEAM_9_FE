import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:bommeong/models/home/dog_state.dart';
import '../providers/AuthController.dart';

class GetDogList {
  Future<List<DogList>> fetchItems(int pageKey) async {
    String? mainpageAPI = dotenv.env['mainpageAPI'];
    var token = Get.find<AuthController>().token; // AuthController에서 token 가져오기

    final response = await http.get(
      Uri.parse(mainpageAPI!),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        // 'Authorization': 'Bearer $access_token',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      List<DogList> items = body.map((dynamic item) => DogList.fromJson(item)).toList();
      print("가져왔음");
      return items;
    } else {
      throw Exception('Failed to load items');
    }
  }

  // Future<List<DogList>> fetchItems(int pageKey) async {
  //   // API 대신 사용할 더미 데이터
  //   await Future.delayed(Duration(seconds: 1)); // 네트워크 요청을 흉내내기 위한 딜레이
  //
  //   List<DogList> items = List.generate(10, (index) {
  //     // 각 페이지마다 고유한 데이터를 생성하기 위해 pageKey와 index를 사용
  //     int id = pageKey * 10 + index;
  //     return DogList(
  //       id: id,
  //       name:'Dog #$id',
  //       age: 'old', // 가정한 나이 데이터
  //       type: (id % 2 == 0) ? 'Labrador' : 'Beagle', // 간단한 조건으로 타입을 정함
  //       favourite: false, // 기본값
  //       imagePath: 'https://ifh.cc/g/tBmzjl.jpg',
  //     );
  //   });
  //
  //   return items;
  // }
}

class GetLikeDogList {
  Future<List<DogList>> fetchItems(int pageKey) async {
    String? likepageAPI = dotenv.env['likepageAPI'];
    var token = Get.find<AuthController>().token;
    var memberId = Get.find<AuthController>().memberIdValue;

    String url = '$likepageAPI/$memberId';

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      List<DogList> items = body.map((dynamic item) => DogList.fromJson(item)).toList();
      print("가져왔음");
      return items;
    } else {
      // 요청 실패 처리
      throw Exception('Failed to load data');
    }
  }
}

class GetDogInfo {
  Future<DogInfo> fetchItems(int id) async {
    // API 대신 사용할 더미 데이터
    await Future.delayed(Duration(seconds: 1)); // 네트워크 요청을 흉내내기 위한 딜레이

    return DogInfo(
        id: id,
        name:'Dog #$id',
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
        status: id % 2 == 0 ? '아직 친구를 기다리고있어요!' : '좋은친구와 함께하게 됐어요!🎉', // 간단한 조건으로 상태를 정함
        date: DateTime.now().subtract(Duration(days: id)), // 현재로부터 id일 전의 날짜
      );
    });

    return items;
  }

  // Future<List<DogList>> fetchItems(int pageKey) async {
  //   String? chatlogAPI = dotenv.env['chatlogAPI'];
  //   var token = Get.find<AuthController>().token;
  //   var memberId = Get.find<AuthController>().memberIdValue;
  //
  //   String url = '$chatlogAPI/$memberId';
  //
  //   final response = await http.get(
  //     Uri.parse(url),
  //     headers: {
  //       'Content-Type': 'application/json',
  //       'Authorization': 'Bearer $token',
  //     },
  //   );
  //
  //   if (response.statusCode == 200) {
  //     List<dynamic> body = json.decode(response.body);
  //     List<DogList> items = body.map((dynamic item) => DogList.fromJson(item)).toList();
  //     return items;
  //   } else {
  //     // 요청 실패 처리
  //     throw Exception('Failed to load data');
  //   }
  // }
}