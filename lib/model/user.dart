class User {
  final String userName;
  final String token;
  final String email;
  final String userId;

  User(this.userName, this.token, this.email, this.userId);

  User.fromJson(Map<String, dynamic> json)
      : userName = json['name'],
        token = json['token'],
        email = json['email'],
        userId = json['userId'];

  Map<String, dynamic> toJson() => {
        'name': userName,
        'token': token,
        'email': email,
        'userId': userId,
      };
}
