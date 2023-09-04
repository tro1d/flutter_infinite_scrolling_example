import 'package:flutter/material.dart';
import 'package:infinite_scrolling_example/utils/generate_random_post.dart';

class StoryNotifier extends ChangeNotifier {
  List<String> _storyList = [];
  bool hasLimitStory = false;
  int takeStoryList = 10;

  List<String> get storyList => _storyList;

  final scrollStoryCTRL = ScrollController();

  void onInit() {
    getDataStoryFromList();
    scrollStoryCTRL.addListener(() {
      if (scrollStoryCTRL.position.maxScrollExtent == scrollStoryCTRL.offset) {
        getDataStoryFromList();
      }
    });
  }

  void onDispose() {
    scrollStoryCTRL.dispose();
  }

  void getDataStoryFromList() {
    final forExample = HiImFay();
    final List<String> dataPictures = forExample.listProfilePicture(50);
    final allItem = dataPictures.take(takeStoryList);
    if (allItem.length == storyList.length) hasLimitStory = true;
    takeStoryList += 5;
    _storyList = allItem.toList();
    notifyListeners();
  }

  void onStoryReload() {
    _storyList.clear();
    hasLimitStory = false;
    takeStoryList = 10;
    getDataStoryFromList();
    scrollStoryCTRL.position.moveTo(
      1,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInSine,
    );
  }
}
