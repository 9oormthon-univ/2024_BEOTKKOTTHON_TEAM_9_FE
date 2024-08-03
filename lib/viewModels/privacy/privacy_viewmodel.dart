import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import '../../models/privacy/privacy_state.dart';
import '../../services/privacy_service.dart';
import '../../services/userpreferences_service.dart';

class PrivacyViewModel extends GetxController {
  final PrivacyService _userService = PrivacyService();

  // 컨트롤러
  final TextEditingController setPetHistoryController = TextEditingController();
  final TextEditingController setCurrentPetController = TextEditingController();
  final TextEditingController setReasonForAdoptionController = TextEditingController();

  // ViewModel 변수들
  var petHistoryAnswer = ''.obs;
  var familyAnswer = ''.obs;
  var familyAgreement = ''.obs;
  var currentPetAnswer = ''.obs;
  var dogNewsAnswer = ''.obs;
  var gender = ''.obs;
  var neutered = ''.obs;
  File? uploadFile;

  // 각 변수에 대한 setter
  void setGender(String value) => gender.value = value;
  void setNeutered(String value) => neutered.value = value;
  void updateUploadFile(File selectedPicture) => uploadFile = selectedPicture;
  void setPetHistoryAnswer(String value) => petHistoryAnswer.value = value;
  void setFamilyAnswer(String value) => familyAnswer.value = value;
  void setFamilyAgreement(String value) => familyAgreement.value = value;
  void setCurrentPetAnswer(String value) => currentPetAnswer.value = value;
  void setDogNewsAnswer(String value) => dogNewsAnswer.value = value;

  // AdoptApplication 생성
  AdoptApplication createAdoptApplication() {
    return AdoptApplication(
      petHistoryAnswer: petHistoryAnswer.value,
      petHistory: setPetHistoryController.text,
      familyAnswer: familyAnswer.value,
      familyAgreement: familyAgreement.value,
      currentPetAnswer: currentPetAnswer.value,
      currentPet: setCurrentPetController.text,
      reasonForAdoption: setReasonForAdoptionController.text,
      dogNewsAnswer: dogNewsAnswer.value,
    );
  }

  // 서버에 데이터를 전송
  Future<bool> attemptPost() async {
    // AdoptApplication 생성
    final application = createAdoptApplication();

    // 사용자 ID 가져오기
    final memberId = UserPreferences.getMemberId();
    final postId = UserPreferences.getPostId();

    // Post 객체 생성
    final post = Post(
      postId: postId.toString(),
      memberId: memberId.toString(),
      uploadFile: uploadFile,  // 이미지를 File 객체로 전달
      adoptApplication: application,
    );
    return await _userService.submitAnnouncement(post);
  }
}

