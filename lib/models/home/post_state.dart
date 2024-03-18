import 'dart:io';

class Announcement {
  String announcementNumber;
  String name;
  String character;
  String likes;
  String fears;
  String foundLocation;
  String shelterExperience;
  String message;
  String selectedGender;
  File? dogPicture;

  Announcement({
    this.announcementNumber = '',
    this.name = '',
    this.character = '',
    this.likes = '',
    this.fears = '',
    this.foundLocation = '',
    this.shelterExperience = '',
    this.message = '',
    this.selectedGender = '',
    this.dogPicture = null,
  });
}
