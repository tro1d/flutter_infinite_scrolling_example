import 'package:flutter/material.dart';
import 'package:infinite_scrolling_example/models/post.dart';
import 'package:infinite_scrolling_example/utils/generate_random_post.dart';

class PostNotifier extends ChangeNotifier {
  List<Post> _postList = [];
  bool hasLimitPost = false;
  int takepostList = 10;

  List<Post> get postList => _postList;

  final scrollPostCTRL = ScrollController();

  void onInit() {
    getDataPostFromList();

    scrollPostCTRL.addListener(() {
      if (scrollPostCTRL.position.maxScrollExtent == scrollPostCTRL.offset) {
        getDataPostFromList();
      }
    });
  }

  void onDispose() {
    scrollPostCTRL.dispose();
  }

  void getDataPostFromList() {
    final forExample = HiImFay();
    final List<Post> dataPosts = forExample.listPost(200);
    final allPost = dataPosts.take(takepostList);
    if (allPost.length == postList.length) hasLimitPost = true;
    takepostList += 5;
    _postList = allPost.toList();
    notifyListeners();
  }

  void onPostBackToTop() {
    scrollPostCTRL.position.moveTo(
      1,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInSine,
    );
  }
}
