import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:movie_app/helpers/token.dart';
import 'package:movie_app/constants.dart';
import 'package:http/http.dart' as http;

class FavouritesProvider with ChangeNotifier {
  Future<List<Map<String, dynamic>>?> getAllFavourites(String type) async {
    var token = await Token.getJwtToken();
    var apiController = type == "C"
        ? 'contents'
        : type == "M"
            ? 'movies'
            : 'series';

    var apiUrl = '${Constants.baseUrl}/${apiController}/favourites';
    var headers = {
      "Content-Type": "application/json",
      "Accept": "*/*",
      "Accept-Encoding": "gzip, deflate, br",
      "Authorization": "Bearer $token"
    };
    var result = await http.get(
      Uri.parse(apiUrl),
      headers: headers,
    );

    if (result.statusCode != 200) return null;
    var resultList = (jsonDecode(utf8.decode(result.bodyBytes)) as List)
        .map((e) => e as Map<String, dynamic>)
        .toList();

    return resultList;
  }
}
