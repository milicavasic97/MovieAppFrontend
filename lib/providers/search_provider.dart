import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:movie_app/constants.dart';
import 'package:movie_app/helpers/token.dart';

class SearchProvider with ChangeNotifier {
  late final Map<int, List<Map<String, dynamic>>> _contentsList = {};
  late final Map<int, List<Map<String, dynamic>>> _moviesList = {};
  late final Map<int, List<Map<String, dynamic>>> _seriesList = {};
  List<Map<String, dynamic>> _searchList = [];

  List<Map<String, dynamic>> getContentsList(int genreId, String type) =>
      type == "A"
          ? [..._contentsList[genreId]!.toList()]
          : type == "M"
              ? [..._moviesList[genreId]!.toList()]
              : [..._seriesList[genreId]!.toList()];
  List<Map<String, dynamic>> get searchList => [..._searchList];

  Future<List<Map<String, dynamic>>?> getContentByGenreAndType(
      int genreId, String type) async {
    var apiController = type == "A"
        ? 'contents'
        : type == "M"
            ? 'movies'
            : 'series';

    var apiUrl =
        '${Constants.baseUrl}/$apiController/by-genre?genreId=$genreId';
    var token = await Token.getJwtToken();

    var headers = {
      "Content-Type": "application/json",
      "Accept": "*/*",
      "Accept-Encoding": "gzip, deflate, br",
      "Authorization": "Bearer $token",
    };

    var res = await http.get(
      Uri.parse(apiUrl),
      headers: headers,
    );

    if (res.statusCode != 200) return null;

    var resList = (jsonDecode(utf8.decode(res.bodyBytes)) as List)
        .map((e) => e as Map<String, dynamic>)
        .toList();

    if (type == "A") {
      _contentsList.addAll({genreId: resList});
    } else if (type == "M") {
      _moviesList.addAll({genreId: resList});
    } else {
      _seriesList.addAll({genreId: resList});
    }
    return resList;
  }

  Future<List<Map<String, dynamic>>?> getAllGenres() async {
    var apiUrl = Constants.baseUrl;
    var token = await Token.getJwtToken();

    var headers = {
      "Content-Type": "application/json",
      "Accept": "*/*",
      "Accept-Encoding": "gzip, deflate, br",
      "Authorization": "Bearer $token",
    };

    var res = await http.get(
      Uri.parse('$apiUrl/genres'),
      headers: headers,
    );

    if (res.statusCode != 200) return null;

    var resList = (jsonDecode(utf8.decode(res.bodyBytes)) as List)
        .map((e) => e as Map<String, dynamic>)
        .toList();

    return resList;
  }

  void searchContent(String searchText) {
    _searchList = [];

    _contentsList.forEach((key, value) {
      _addItemsToTheSearchList(searchText, _contentsList, key);
    });

    notifyListeners();
  }

  void _addItemsToTheSearchList(
    String searchText,
    Map<int, List<Map<String, dynamic>>> list,
    int key,
  ) {
    for (var contentElement in list[key] ?? []) {
      if (contentElement['title'].toString().toLowerCase().startsWith(
                searchText.toLowerCase(),
              ) &&
          !checkIfContentAlreadyExists(contentElement)) {
        _searchList.add(contentElement);
      }
    }
  }

  bool checkIfContentAlreadyExists(Map<String, dynamic> content) {
    for (var searchElement in _searchList) {
      if (searchElement['title'].toString().contains(content['title'])) {
        return true;
      }
    }
    return false;
  }
}
