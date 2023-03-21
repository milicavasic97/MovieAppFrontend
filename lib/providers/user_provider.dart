import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:movie_app/constants.dart';
import 'package:movie_app/helpers/token.dart';
import 'package:http/http.dart' as http;

class UserProvider with ChangeNotifier {
  Future<Map<String, dynamic>?> getUserDetails() async {
    var apiUrl = Constants.baseUrl;
    var token = await Token.getJwtToken();

    var headers = {
      "Content-Type": "application/json",
      "Accept": "*/*",
      "Accept-Encoding": "gzip, deflate, br",
      "Authorization": "Bearer $token",
    };

    var response = await http.get(
      Uri.parse('$apiUrl/users/details'),
      headers: headers,
    );
    if (response.statusCode != 200) return null;

    return jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
  }
}
