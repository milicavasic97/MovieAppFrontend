import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:movie_app/constants.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/helpers/token.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginProvider extends ChangeNotifier {
  Future<bool> login(String username, String password) async {
    var apiUrl = "${Constants.baseUrl}/users/login";
    var headers = {
      "Content-Type": "application/json",
      "Accept": "*/*",
      "Accept-Encoding": "gzip, deflate, br"
    };

    log(username);
    log(password);
    log(apiUrl);

    var res = await http.post(
      Uri.parse(apiUrl),
      headers: headers,
      body: jsonEncode({
        "username": username,
        "password": password,
      }),
    );

    log(res.statusCode.toString());

    log((jsonDecode(res.body) as Map<String, dynamic>)['jwt'].toString());

    if (res.statusCode != 200) return false;
    Token.saveToken(
        (jsonDecode(res.body) as Map<String, dynamic>)['jwt'].toString());
    return true;
  }

  Future<String?> getJwtToken() async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.getString("token");
  }

  Future<void> logOut() async {
    await Token.removeToken();
    notifyListeners();
  }
}
