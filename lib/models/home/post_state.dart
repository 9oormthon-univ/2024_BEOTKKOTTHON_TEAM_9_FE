import 'dart:io';

class Announcement {
  String name;
  String age;
  String character;
  String extra;
  String breed;
  String like;
  String hate;
  String findingLocation;
  String selectedGender;
  File? dogPicture;

  Announcement({
    this.name = '',
    this.age = '',
    this.character = '',
    this.extra = '',
    this.breed = '',
    this.like = '',
    this.hate = '',
    this.findingLocation = '',
    this.selectedGender = '',
    this.dogPicture,
  });
}
