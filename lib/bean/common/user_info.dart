class UserInfo {
  String token;
  int user_id;
  String email;

  UserInfo.fromJson(Map<String, dynamic> json)
      : token = json['token'],
        user_id = json['user_id'],
        email = json['email'];

  Map<String, dynamic> toJson() => {
        'token': token,
        'user_id': user_id,
        'email': email,
      };

  @override
  String toString() {
    return 'UserInfo{token: $token, user_id: $user_id, email: $email}';
  }
}
