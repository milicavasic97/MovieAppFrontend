import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:movie_app/constants.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/helpers/token.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeProvider extends ChangeNotifier {
  Future<List<Map<String, dynamic>>> getContentByReleaseDate(
      String type) async {
    var apiController = type == "M" ? 'movies' : 'series';
    var apiUri = '${Constants.baseUrl}/${apiController}/by-release-date';
    var token = await Token.getJwtToken();
    var headers = {
      "Content-Type": "application/json",
      "Accept": "*/*",
      "Accept-Encoding": "gzip, deflate, br",
      "Authorization": "Bearer $token",
    };

    var res = await http.get(
      Uri.parse(apiUri),
      headers: headers,
    );

    var resList = (jsonDecode(utf8.decode(res.bodyBytes)) as List)
        .map((e) => e as Map<String, dynamic>)
        .toList();

    return resList;
  }

  Future<List<Map<String, dynamic>>> getContentByRating(String type) async {
    var apiController = type == "M" ? 'movies' : 'series';
    var apiUri = '${Constants.baseUrl}/${apiController}/by-rating';
    var token = await Token.getJwtToken();
    var headers = {
      "Content-Type": "application/json",
      "Accept": "*/*",
      "Accept-Encoding": "gzip, deflate, br",
      "Authorization": "Bearer $token",
    };

    var res = await http.get(
      Uri.parse(apiUri),
      headers: headers,
    );

    var resList = (jsonDecode(utf8.decode(res.bodyBytes)) as List)
        .map((e) => e as Map<String, dynamic>)
        .toList();

    return resList;
  }

  Future<List> getContentById(int genreId) async {
    var apiUrl = '${Constants.baseUrl}/contents/by-genre';
    var token = await Token.getJwtToken();

    var headers = {
      "Content-Type": "application/json",
      "Accept": "*/*",
      "Accept-Encoding": "gzip, deflate, br",
      "Authorization": "Bearer $token",
    };

    var res = await http.post(
      Uri.parse(apiUrl),
      headers: headers,
      body: jsonEncode({"genreId": genreId}),
    );

    var a = jsonDecode(res.body) as List<dynamic>;

    return a;
  }
}
