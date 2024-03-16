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