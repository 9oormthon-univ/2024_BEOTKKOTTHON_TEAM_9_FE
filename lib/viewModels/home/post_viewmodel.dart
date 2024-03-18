import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/home/post_state.dart';
import 'dart:io';

class PostController extends GetxController {
  final Announcement announcement = Announcement();

  void updateAnnouncementNumber(String number) {
    announcement.announcementNumber = number;
    update();
  }

  void updateName(String name) {
    announcement.name = name;
    update();
  }

  void updateCharacter(String character) {
    announcement.character = character;
    update();
  }

  void updateLikes(String likes) {
    announcement.likes = likes;
    update();
  }

  void updateFears(String fears) {
    announcement.fears = fears;
    update();
  }

  void updateFoundLocation(String foundLocation) {
    announcement.foundLocation = foundLocation;
    update();
  }

  void updateShelterExperience(String shelterExperience) {
    announcement.shelterExperience = shelterExperience;
    update();
  }

  void updateMessage(String message) {
    announcement.message = message;
    update();
  }

  void updateSelectedGender(String selectedGender) {
    announcement.selectedGender = selectedGender;
    update();
  }

  void updateDogPicture(File? selectedPicture) {
    announcement.dogPicture = selectedPicture;
    update();
  }

  String getGender(){
    return announcement.selectedGender;
  }

  bool get isFormValid {
    return announcement.announcementNumber.isNotEmpty &&
        announcement.name.isNotEmpty &&
        announcement.character.isNotEmpty &&
        announcement.likes.isNotEmpty &&
        announcement.fears.isNotEmpty &&
        announcement.foundLocation.isNotEmpty &&
        announcement.shelterExperience.isNotEmpty &&
        announcement.message.isNotEmpty &&
        announcement.selectedGender.isNotEmpty;
  }

  void printValue() {
    print('Announcement Number: ${announcement.announcementNumber}');
    print('Name: ${announcement.name}');
    print('Character: ${announcement.character}');
    print('Likes: ${announcement.likes}');
    print('Fears: ${announcement.fears}');
    print('Found Location: ${announcement.foundLocation}');
    print('Shelter Experience: ${announcement.shelterExperience}');
    print('Message: ${announcement.message}');
    print('Selected Gender: ${announcement.selectedGender}');
  }

  void matchCharacter(String idx){
    if(idx == "0")announcement.character = "자신감이 넘처요";
    if(idx == "1")announcement.character = "부끄러움이 많고 소심해요";
    if(idx == "2")announcement.character = "활발하고 긍정적이에요";
    if(idx == "3")announcement.character = "독립적에요";
    if(idx == "4")announcement.character = "사람을 좋아해요";

  }


  void submitForm() {
    print("Form submitted with data: ${announcement.announcementNumber}, ${announcement.name}");
  }
}
