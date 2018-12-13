class User {
  final String userName;
  final String token;
  final String email;
  final int userId;

  User(this.userName, this.token, this.email, this.userId);

  User.fromJson(Map<String, dynamic> json)
      : userName = json['name'],
        token = json['token'],
        email = json['email'],
        userId = json['pk'];

  Map<String, dynamic> toJson() => {
        'name': userName,
        'token': token,
        'email': email,
        'pk': userId,
      };
}
