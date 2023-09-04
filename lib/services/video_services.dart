import 'package:flutter/material.dart';
import 'package:infinite_scrolling_example/utils/generate_random_post.dart';

class VideoNotifier extends ChangeNotifier {
  bool _isVideosVisible = true;
  List<String> _videoList = [];
  bool hasLimitVideo = false;
  int takeVideoList = 5;

  bool get isVideosVisible => _isVideosVisible;
  List<String> get videoList => _videoList;

  final scrollVideosCTRL = ScrollController();

  void onInit() {
    getDataVideoFromList();
    scrollVideosCTRL.addListener(() {
      if (scrollVideosCTRL.position.maxScrollExtent == scrollVideosCTRL.offset) {
        getDataVideoFromList();
      }
    });
  }

  void onDispose() {
    scrollVideosCTRL.dispose();
  }

  void getDataVideoFromList() {
    final forExample = HiImFay();
    final List<String> dataPictures = forExample.listLightBoxPicture(25);
    final allVideo = dataPictures.take(takeVideoList);
    if (allVideo.length == videoList.length) hasLimitVideo = true;
    takeVideoList += 5;
    _videoList = allVideo.toList();
    notifyListeners();
  }

  void onVideoReload() {
    _videoList.clear();
    hasLimitVideo = false;
    takeVideoList = 5;
    getDataVideoFromList();
    scrollVideosCTRL.position.moveTo(
      1,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInSine,
    );
  }

  void onVideoVisibile() {
    _isVideosVisible = !_isVideosVisible;
    notifyListeners();
  }
}
