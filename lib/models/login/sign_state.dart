class User {
  String email;
  String password;
  String name;
  String phone;
  String membertype;

  User({required this.email, required this.password, required this.name, required this.phone, required this.membertype});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email'] as String,
      password: json['password'] as String,
      name: json['name'] as String,
      phone: json['phone'] as String,
      membertype: json['memberType'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'name': name,
      'phone': phone,
      'memberType': membertype,
    };
  }
}