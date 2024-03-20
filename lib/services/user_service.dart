import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:bommeong/models/home/dog_state.dart';


class GetDogList {
  Future<List<DogList>> fetchItems(int pageKey) async {
    // API 대신 사용할 더미 데이터
    await Future.delayed(Duration(seconds: 1)); // 네트워크 요청을 흉내내기 위한 딜레이

    List<DogList> items = List.generate(10, (index) {
      // 각 페이지마다 고유한 데이터를 생성하기 위해 pageKey와 index를 사용
      int id = pageKey * 10 + index;
      return DogList(
        id: id,
        name:'Dog #$id',
        age: 'old', // 가정한 나이 데이터
        type: (id % 2 == 0) ? 'Labrador' : 'Beagle', // 간단한 조건으로 타입을 정함
        favourite: false, // 기본값
        imagePath: 'https://ifh.cc/g/tBmzjl.jpg',
      );
    });

    return items;
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

  void update() {


  }
}