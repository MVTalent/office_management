import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:office_management/common/constants.dart' as Constants;

class RestClient {
  Future<http.Response> post(String url, var body) {
    return http.post(url, body: body, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    });
  }

  Future<String> signIn(String email, String password) async {
    String url = Uri.encodeFull(
        'https://www.googleapis.com/identitytoolkit/v3/relyingparty/verifyPassword?key=' +
            Constants.KEY);
    http.Response response = await post(
        url,
        json.encode({
          "email": email,
          "password": password,
          "returnSecureToken": 'true'
        }));
    return response.body;
  }

  Future<String> signUp(String email, String password) async {
    String url = Uri.encodeFull(
        'https://www.googleapis.com/identitytoolkit/v3/relyingparty/signupNewUser?key=' +
            Constants.KEY);
    http.Response response = await post(url,
        {"email": email, "password": password, "returnSecureToken": 'true'});

    return response.body;
  }
}
