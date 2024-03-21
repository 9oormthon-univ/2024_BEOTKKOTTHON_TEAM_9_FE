import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import '../../models/privacy/privacy_state.dart';
import '../../services/privacy_service.dart';

class PrivacyViewModel extends GetxController {
  final Privacy announcement = Privacy();
  final PrivacyService _userService = PrivacyService();
  final TextEditingController firstConsent = TextEditingController();
  final TextEditingController firstResponse = TextEditingController();
  final TextEditingController secondResponse = TextEditingController();
  final TextEditingController thirdResponse = TextEditingController();
  final TextEditingController fourthResponse = TextEditingController();
  final TextEditingController firstAdoptionResponse = TextEditingController();
  final TextEditingController secondAdoptionResopnse = TextEditingController();

  void updateUploadFile(File selectedPicture) {
    announcement.uploadFile = selectedPicture;
    update();
  }

  // void updateCharacter(String character) {
  //   matchCharacter(character);
  //   update();
  // }

  // void matchCharacter(String idx){
  //   if(idx == "0")announcement.character = "자신감이 넘처요";
  //   if(idx == "1")announcement.character = "부끄러움이 많고 소심해요";
  //   if(idx == "2")announcement.character = "활발하고 긍정적이에요";
  //   if(idx == "3")announcement.character = "독립적에요";
  //   if(idx == "4")announcement.character = "사람을 좋아해요";
  // }

  Future<bool> attemptpost() async {
    return _userService.submitAnnouncement(
      firstConsent.text,
      firstResponse.text,
      secondResponse.text,
      thirdResponse.text,
      fourthResponse.text,
      firstAdoptionResponse.text,
      secondAdoptionResopnse.text,
      announcement.uploadFile,
    );
  }
}
