import 'package:flutter/material.dart';
import 'package:infinite_scrolling_example/screens/ui/widgets/post_card.dart';
import 'package:infinite_scrolling_example/screens/ui/widgets/story_card_horizontal.dart';
import 'package:infinite_scrolling_example/screens/ui/widgets/video_card_horizontal.dart';
import 'package:infinite_scrolling_example/services/post_services.dart';
import 'package:infinite_scrolling_example/services/story_services.dart';
import 'package:infinite_scrolling_example/services/video_services.dart';

class InfiniteLocalScreen extends StatefulWidget {
  const InfiniteLocalScreen({super.key});

  @override
  State<InfiniteLocalScreen> createState() => _InfiniteLocalScreenState();
}

class _InfiniteLocalScreenState extends State<InfiniteLocalScreen> {
  final PostNotifier posts = PostNotifier();
  final StoryNotifier stories = StoryNotifier();
  final VideoNotifier videos = VideoNotifier();

  @override
  void initState() {
    super.initState();
    posts.onInit();
    stories.onInit();
    videos.onInit();
  }

  @override
  void dispose() {
    posts.onDispose();
    stories.onDispose();
    videos.onDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Infinite Scrolling'),
        actions: <Widget>[
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.switch_access_shortcut),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: ListView(
          controller: posts.scrollPostCTRL,
          children: <Widget>[
            StoryCardHorizontal(service: stories),
            VideoCardHorizontal(service: videos),
            ListenableBuilder(
              listenable: posts,
              builder: (context, child) => Column(
                children: postCardVertical(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  postCardVertical() {
    return List.generate(
      posts.postList.length + 1,
      (index) {
        if (index < posts.postList.length) {
          return PostCard(post: posts.postList[index]);
        }
        if (posts.postList.isEmpty && posts.hasLimitPost) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 32),
              child: Text('Empty'),
            ),
          );
        } else {
          if (!posts.hasLimitPost) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 32),
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: OutlinedButton.icon(
                  icon: const Text('Back to Top'),
                  label: const Icon(Icons.arrow_upward),
                  onPressed: posts.onPostBackToTop,
                ),
              ),
            );
          }
        }
      },
    );
  }
}
