import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AppServicesBasic extends ChangeNotifier {
  AppServicesBasic() {
    _initAppServicesBasic();
  }

  final List<String> _postList = [];
  bool hasLimitPost = false;
  int pagePostList = 1;

  final List<String> _pictureList = [];
  bool hasLimitPicture = false;
  int pagePictureList = 497;

  List<String> get postList => _postList;
  List<String> get pictureList => _pictureList;

  final scrollCTRL = ScrollController();
  final scrollPicrtureCTRL = ScrollController();

  void scrollListener() {
    scrollPicrtureCTRL.addListener(() {
      if (scrollPicrtureCTRL.position.maxScrollExtent == scrollPicrtureCTRL.offset) {
        getDataPicture();
      }
    });
    scrollCTRL.addListener(() {
      if (scrollCTRL.position.maxScrollExtent == scrollCTRL.offset) {
        getDataPost();
      }
    });
  }

  Future<void> getDataPicture() async {
    try {
      String api = 'https://jsonplaceholder.typicode.com/photos?_page=$pagePictureList&_limit=10';
      final http.Client client = http.Client();
      final response = await client.get(Uri.parse(api)).timeout(const Duration(seconds: 5));
      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body);
        final List<String> body = data.map<String>((e) => e['url']).toList();
        if (body.length + pictureList.length == pictureList.length) hasLimitPicture = true;
        pagePictureList++;
        _pictureList.addAll(body);
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Failed Get Picture: $e');
    }
    debugPrint('Get Pictures: FAY ==>> ${pictureList.length}');
  }

  void reloadPicture() {
    pictureList.clear();
    hasLimitPicture = false;
    pagePictureList = 497;
    getDataPicture();
  }

  Future<void> getDataPost() async {
    try {
      String api = 'https://jsonplaceholder.typicode.com/posts?_page=$pagePostList&_limit=10';
      final http.Client client = http.Client();
      final response = await client.get(Uri.parse(api)).timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body);
        final List<String> body = data.map<String>((e) => e['body']).toList();
        if (body.length + _postList.length == _postList.length) hasLimitPost = true;
        pagePostList++;
        _postList.addAll(body);
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Failed Get Post: $e');
    }
    debugPrint('Get Posts: FAY ==>> ${postList.length}');
  }

  void reloadPost() {
    postList.clear();
    hasLimitPost = false;
    pagePostList = 1;
    getDataPost();
  }

  _initAppServicesBasic() {
    getDataPicture();
    getDataPost();
  }
}
