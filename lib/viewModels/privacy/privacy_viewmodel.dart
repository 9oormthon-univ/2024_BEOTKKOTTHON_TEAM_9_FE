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

  var gender = ''.obs;
  var neutered = ''.obs;

  // 질문 번호를 관리하는 변수
  var questionNum = 0.obs;

  // 각 질문에 대한 대답을 관리하는 변수
  var firstQuestionResponse = ''.obs;
  var secondQuestionResponse = ''.obs;
  var thirdQuestionResponse = ''.obs;
  var fourthQuestionPetType = ''.obs;
  var fourthQuestionPetAge = ''.obs;
  var fourthQuestionGender = ''.obs;
  var fourthQuestionNeutered = ''.obs;
  var fifthQuestionResponse = ''.obs;
  var sixthQuestionResponse = ''.obs;
  var seventhQuestionResponse = ''.obs;
  var eighthQuestionResponse = ''.obs;

  // 질문 번호를 업데이트하는 메서드
  void updateQuestionNum(int value) {
    questionNum.value = value;
  }

  // 각 질문의 대답을 업데이트하는 메서드
  void updateFirstQuestionResponse(String value) {
    firstQuestionResponse.value = value;
  }

  void updateSecondQuestionResponse(String value) {
    secondQuestionResponse.value = value;
  }

  void updateThirdQuestionResponse(String value) {
    thirdQuestionResponse.value = value;
  }

  void updateFourthQuestionPetType(String value) {
    fourthQuestionPetType.value = value;
  }

  void updateFourthQuestionPetAge(String value) {
    fourthQuestionPetAge.value = value;
  }

  void updateFourthQuestionGender(String value) {
    fourthQuestionGender.value = value;
  }

  void updateFourthQuestionNeutered(String value) {
    fourthQuestionNeutered.value = value;
  }

  void updateFifthQuestionResponse(String value) {
    fifthQuestionResponse.value = value;
  }

  void updateSixthQuestionResponse(String value) {
    sixthQuestionResponse.value = value;
  }

  void updateSeventhQuestionResponse(String value) {
    seventhQuestionResponse.value = value;
  }

  void updateEighthQuestionResponse(String value) {
    eighthQuestionResponse.value = value;
  }

  void updateUploadFile(File selectedPicture) {
    announcement.uploadFile = selectedPicture;
    update();
  }

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

  void setGender(String value) {
    gender.value = value;
  }

  void setNeutered(String value) {
    neutered.value = value;
  }
}
