class AdoptionInfo {
  final int? adoptId;
  final int? postId;
  final int? memberId;
  final String? imageUrl;
  final String? imageName;
  final dynamic uploadFile; // 정확한 타입이 명시되지 않았으므로 dynamic을 사용
  final String? status;
  // adoptApplication은 여기서는 생략하겠습니다. 필요에 따라 추가하세요.

  AdoptionInfo({
    this.adoptId,
    this.postId,
    this.memberId,
    this.imageUrl,
    this.imageName,
    this.uploadFile,
    this.status,
  });

  factory AdoptionInfo.fromJson(Map<String, dynamic> json) {
    return AdoptionInfo(
      adoptId: json['adoptId'] as int?,
      postId: json['postId'] as int?,
      memberId: json['memberId'] as int?,
      imageUrl: json['imageUrl'] as String?,
      imageName: json['imageName'] as String?,
      uploadFile: json['uploadFile'],
      status: json['status'] as String?,
    );
  }
}


class UserInfoModel {
  final bool? isHaveDog; // nullable로 변경
  final String userName;
  final String membertype;
  final String useremail;
  final String? applyAdoption; // nullable로 변경
  final String? dogImage; // nullable로 변경
  final String? dogname; // nullable로 변경
  final AdoptionInfo? adoption; // adoption 필드 추가

  UserInfoModel({
    this.isHaveDog, // required 제거 및 nullable로 변경
    required this.userName,
    required this.membertype,
    required this.useremail,
    this.applyAdoption, // required 제거 및 nullable로 변경
    this.dogImage, // required 제거 및 nullable로 변경
    this.dogname, // required 제거 및 nullable로 변경
    this.adoption, // 새로운 필드 추가
  });

  factory UserInfoModel.fromJson(Map<String, dynamic> json) {
    return UserInfoModel(
      isHaveDog: json['isHaveDog'] as bool? ?? false, // 기본값으로 false 설정
      userName: json['name'] as String,
      membertype: json['memberType'] as String,
      useremail: json['email'] as String,
      applyAdoption: json['applyAdoption'] as String? ?? "assets/images/my/progress1.svg", // 기본값 설정
      dogImage: json['imageUrl'] as String? ?? "assets/images/my/miniDog.png", // 기본 이미지 경로 설정
      dogname: "날봄", // 기본 이름 설정
      adoption: json['adoption'] != null ? AdoptionInfo.fromJson(json['adoption']) : null, // adoption 처리
    );
  }

}
