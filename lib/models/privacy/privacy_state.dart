import 'dart:io';

class Privacy {
  File? uploadFile;
  String firstConsent;
  String firstResponse;
  String secondResponse;
  String thirdResponse;
  String fourthResponse;
  String firstAdoptionResponse;
  String secondAdoptionResponse;

  Privacy({
    this.uploadFile,
    this.firstConsent = '',
    this.firstResponse = '',
    this.secondResponse = '',
    this.thirdResponse = '',
    this.fourthResponse = '',
    this.firstAdoptionResponse = '',
    this.secondAdoptionResponse = '',
  });
}