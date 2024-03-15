import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:bommeong/models/home/doglist_state.dart';


class GetDogList {
  // Future<List<DogList>> fetchItems(int pageKey) async {
  //   final response = await http.get(Uri.parse('YOUR_API_ENDPOINT'));
  //
  //   if (response.statusCode == 200) {
  //     List<dynamic> body = json.decode(response.body);
  //     List<DogList> items = body.map((dynamic item) => DogList.fromJson(item)).toList();
  //     return items;
  //   } else {
  //     throw Exception('Failed to load items');
  //   }
  // }
  Future<List<DogList>> fetchItems(int pageKey) async {
    // API 대신 사용할 더미 데이터
    await Future.delayed(Duration(seconds: 1)); // 네트워크 요청을 흉내내기 위한 딜레이

    List<DogList> items = List.generate(10, (index) {
      // 각 페이지마다 고유한 데이터를 생성하기 위해 pageKey와 index를 사용
      int id = pageKey * 10 + index;
      return DogList(
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


class GetUserInfo{

}