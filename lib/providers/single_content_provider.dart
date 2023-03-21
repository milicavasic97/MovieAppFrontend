import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:movie_app/constants.dart';
import 'package:movie_app/helpers/token.dart';
import 'package:http/http.dart' as http;

class SingleContentProvider with ChangeNotifier {
  late int _contentId;
  late String _title;
  late String _trailerLink;
  late String _coverLink;
  late bool _isFavorite = false;
  late int _duration;
  late int _year;
  late double _rating;
  late List<dynamic> _genres;
  late List<dynamic> _contentComments;

  String get title => _title;
  int get contentId => _contentId;
  String get trailerLink => _trailerLink;
  String get coverLink => _coverLink;
  int get duration => _duration;
  bool get isFavourite => _isFavorite;
  int get year => _year;
  double get rating => _rating;
  List<dynamic> get genres => [..._genres];
  List<dynamic> get contentComments => [..._contentComments];

  SingleContentProvider();
  SingleContentProvider.value(Map<String, dynamic> data, int contentId) {
    populateData(data, contentId);
  }

  void populateData(Map<String, dynamic> data, int contentId) {
    _contentId = contentId;
    _title = data['title'];
    _trailerLink = data['trailerLink'];
    _coverLink = data['coverLink'];
    _isFavorite = data['favourite'];
    _duration = data['duration'];
    _year = data['year'];
    _rating = data['rating'];
    _genres = data['genres'];
    _contentComments = data['contentComments'];
  }

  void _addCommentToList(String firstName, String lastName, String comment) {
    _contentComments.add({
      "user": {
        "firstName": firstName,
        "lastName": lastName,
      },
      "comment": comment,
      "commentDate": DateTime.now().toString()
    });
    log(firstName + lastName + comment);
    notifyListeners();
  }

  Future<Map<String, dynamic>?> getContentDetails(int contentId) async {
    var apiUrl = Constants.baseUrl;
    var token = await Token.getJwtToken();

    var headers = {
      "Content-Type": "application/json",
      "Accept": "*/*",
      "Accept-Encoding": "gzip, deflate, br",
      "Authorization": "Bearer $token",
    };

    var response = await http.get(
      Uri.parse('$apiUrl/contents/details?contentId=$contentId'),
      headers: headers,
    );

    if (response.statusCode != 200) return null;

    return jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
  }

  Future<bool> addComment(int contentId, String comment) async {
    var apiUrl = Constants.baseUrl;
    var token = await Token.getJwtToken();
    var parsedToken = await Token.decodeJWT();

    var headers = {
      "Content-Type": "application/json",
      "Accept": "*/*",
      "Accept-Encoding": "gzip, deflate, br",
      "Authorization": "Bearer $token",
    };

    var response = await http.post(
      Uri.parse('$apiUrl/contents/comment'),
      body: jsonEncode({
        "contentId": contentId,
        "comment": comment,
        "repayId": null,
      }),
      headers: headers,
    );

    if (response.statusCode == 200) {
      var decodedResult =
          jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;

      _addCommentToList(decodedResult['user']['firstName'],
          decodedResult['user']['lastName'], comment);
    }

    return response.statusCode == 200;
  }

  Future<void> addToFavorites() async {
    var apiUrl = Constants.baseUrl;
    var token = await Token.getJwtToken();
    var parsedToken = await Token.decodeJWT();

    _isFavorite = !_isFavorite;
    var headers = {
      "Content-Type": "application/json",
      "Accept": "*/*",
      "Accept-Encoding": "gzip, deflate, br",
      "Authorization": "Bearer $token",
    };

    var response = await http.post(
      Uri.parse('$apiUrl/contents/mark-favourite'),
      body: jsonEncode({
        "contentId": _contentId,
        "favourite": _isFavorite,
      }),
      headers: headers,
    );

    if (response.statusCode == 200) {
      notifyListeners();
    } else {
      _isFavorite = !_isFavorite;
    }
  }
}
