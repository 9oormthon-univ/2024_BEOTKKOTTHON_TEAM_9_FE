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
