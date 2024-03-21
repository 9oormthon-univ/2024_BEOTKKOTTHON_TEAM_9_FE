class UserInfoModel {
  final bool isHaveDog;
  final String userImage;
  final String userName;
  final String membertype;
  final String useremail;
  final String applyAdoption;
  final String dogImage;
  final String dogname;

  UserInfoModel({
    required this.isHaveDog,
    required this.userImage,
    required this.userName,
    required this.membertype,
    required this.useremail,
    required this.applyAdoption,
    required this.dogImage,
    required this.dogname,
  });

  factory UserInfoModel.fromJson(Map<String, dynamic> json) {
    return UserInfoModel(
      isHaveDog: json['isHaveDog'],
      userImage: json['userImage'],
      userName: json['userName'],
      membertype: json['membertype'],
      useremail: json['useremail'],
      applyAdoption: json['applyAdoption'],
      dogImage: json['dogImage'],
      dogname: json['dogname'],
    );
  }
}
