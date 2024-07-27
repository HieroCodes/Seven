class User {
  final int id;
  final String nickname;
  final String token;

  User({
    required this.id,
    required this.nickname,
    required this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      nickname: json['nickname'],
      token: json['token'],
    );
  }
}
