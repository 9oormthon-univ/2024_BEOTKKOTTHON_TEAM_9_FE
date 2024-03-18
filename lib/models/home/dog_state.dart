import 'package:get/get.dart';


class DogList {
  final int id;
  final String name;
  final String age;
  final String type;
  bool favourite;
  final String imagePath;

  DogList({
    required this.id,
    required this.name,
    required this.age,
    required this.type,
    this.favourite = false,
    required this.imagePath,
  });

  factory DogList.fromJson(Map<String, dynamic> json) {
    return DogList(
      id: json['id'] as int,
      name: json['name'] as String,
      age: json['age'] as String,
      type: json['type'] as String,
      imagePath: json['imagePath'] as String,
    );
  }
}

class DogInfo {
  final int id;
  final String name;
  final String age;
  final String type;
  bool favourite;
  final List<String> tags; // String 배열 타입의 태그
  final String dogTalk; // 개가 하는 말을 나타내는 필드
  final String imagePath;

  DogInfo({
    required this.id,
    required this.name,
    required this.age,
    required this.type,
    this.favourite = false,
    required this.tags,
    required this.dogTalk,
    required this.imagePath,
  });

  factory DogInfo.fromJson(Map<String, dynamic> json) {
    return DogInfo(
      id: json['id'] as int,
      name: json['name'] as String,
      age: json['age'] as String,
      type: json['type'] as String,
      favourite: json['favourite'] as bool? ?? false,
      tags: List<String>.from(json['tags']),
      dogTalk: json['dogTalk'] as String,
      imagePath: json['imagePath'] as String,
    );
  }
}


class ChatList {
  final String imagePath;
  final String name;
  final String status; // 입양 됐는지 아닌지를 알려주는 상태
  final DateTime date; // 마지막 메시지를 받거나 보낸 날짜

  ChatList({
    required this.imagePath,
    required this.name,
    required this.status,
    required this.date,
  });

  factory ChatList.fromJson(Map<String, dynamic> json) {
    return ChatList(
      imagePath: json['imagePath'] as String,
      name: json['name'] as String,
      status: json['status'] as String,
      date: DateTime.parse(json['date'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'imagePath': imagePath,
      'name': name,
      'status': status,
      'date': date.toIso8601String(),
    };
  }
}
