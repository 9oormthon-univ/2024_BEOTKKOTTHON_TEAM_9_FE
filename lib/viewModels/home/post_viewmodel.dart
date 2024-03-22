import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/home/post_state.dart';
import 'dart:io';
import '../../services/post_service.dart';

class PostController extends GetxController {
  final Announcement announcement = Announcement();
  final PostService _userService = PostService();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController PostIdController = TextEditingController();
  final TextEditingController extraController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController breedController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController likeController = TextEditingController();
  final TextEditingController hateController = TextEditingController();
  final TextEditingController findinglocationController = TextEditingController();

  void updateDogPicture(File selectedPicture) {
    announcement.dogPicture = selectedPicture;
    update();
  }

  void updateCharacter(String character) {
    matchCharacter(character);
    update();
  }

  void matchCharacter(String idx){
    if(idx == "0")announcement.character = "자신감이 넘처요";
    if(idx == "1")announcement.character = "부끄러움이 많고 소심해요";
    if(idx == "2")announcement.character = "활발하고 긍정적이에요";
    if(idx == "3")announcement.character = "독립적에요";
    if(idx == "4")announcement.character = "사람을 좋아해요";
  }

  Future<bool> attemptpost() async {
    return _userService.submitAnnouncement(
        PostIdController.text,
        nameController.text,
        announcement.character,
        extraController.text,
        ageController.text,
        breedController.text,
        genderController.text,
        likeController.text,
        hateController.text,
        findinglocationController.text,
        announcement.dogPicture,
    );
  }
}
