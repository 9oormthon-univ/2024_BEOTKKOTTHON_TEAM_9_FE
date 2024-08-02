import 'dart:io';

class AdoptApplication {
  final String petHistoryAnswer;
  final String petHistory;
  final String familyAnswer;
  final String familyAgreement;
  final String currentPetAnswer;
  final String currentPet;
  final String reasonForAdoption;
  final String dogNewsAnswer;

  AdoptApplication({
    required this.petHistoryAnswer,
    required this.petHistory,
    required this.familyAnswer,
    required this.familyAgreement,
    required this.currentPetAnswer,
    required this.currentPet,
    required this.reasonForAdoption,
    required this.dogNewsAnswer,
  });

  factory AdoptApplication.fromJson(Map<String, dynamic> json) {
    return AdoptApplication(
      petHistoryAnswer: json['petHistoryAnswer'] ?? '',
      petHistory: json['petHistory'] ?? '',
      familyAnswer: json['familyAnswer'] ?? '',
      familyAgreement: json['familyAgreement'] ?? '',
      currentPetAnswer: json['currentPetAnswer'] ?? '',
      currentPet: json['currentPet'] ?? '',
      reasonForAdoption: json['reasonForAdoption'] ?? '',
      dogNewsAnswer: json['dogNewsAnswer'] ?? '',
    );
  }

  Map<String, String> toJson() {
    return {
      'petHistoryAnswer': petHistoryAnswer,
      'petHistory': petHistory,
      'familyAnswer': familyAnswer,
      'familyAgreement': familyAgreement,
      'currentPetAnswer': currentPetAnswer,
      'currentPet': currentPet,
      'reasonForAdoption': reasonForAdoption,
      'dogNewsAnswer': dogNewsAnswer,
    };
  }
}

class Post {
  final String postId;
  final String memberId;
  final File? uploadFile;
  final AdoptApplication adoptApplication;

  Post({
    required this.postId,
    required this.memberId,
    required this.uploadFile,
    required this.adoptApplication,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      postId: json['postId'] ?? '',
      memberId: json['memberId'] ?? '',
      uploadFile: File(json['uploadFile']), // Assuming the path is provided
      adoptApplication: AdoptApplication.fromJson(json['adoptApplication'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'postId': postId,
      'memberId': memberId,
      'uploadFile': uploadFile?.path, // Store path for serialization
      'adoptApplication': adoptApplication.toJson(),
    };
  }
}

