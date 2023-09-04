import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scrolling_example/models/post.dart';
import 'package:read_morex/read_morex.dart';

class PostCard extends StatefulWidget {
  const PostCard({Key? key, required this.post}) : super(key: key);

  final Post post;

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  late Post post;
  bool isReadMore = false;
  bool isFavorite = false;

  @override
  void initState() {
    post = widget.post;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(26),
                child: Image.asset(
                  height: 32,
                  width: 32,
                  post.userImage,
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6.0),
                  child: Text(post.userName, style: const TextStyle(fontWeight: FontWeight.w600)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6.0),
                child: Text(_postCreateAt, style: const TextStyle(fontSize: 10, color: Colors.black45)),
              ),
              PopupMenuButton(
                tooltip: '',
                child: const Icon(Icons.more_horiz_rounded),
                itemBuilder: (context) => <PopupMenuEntry<PopupMenuItem>>[
                  PopupMenuItem(enabled: false, child: Text('Hello ${post.userName}')),
                ],
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: ReadMoreX(
                    post.textPost,
                    textStyle: const TextStyle(fontSize: 18),
                    readMoreColor: Colors.green,
                    filterContent: true,
                    fontWeightLabel: FontWeight.normal,
                    customFilter: [
                      ReadMoreXPattern(
                        pattern: r'github.com',
                        valueChanged: (value) => value?.replaceFirst('https://github.com/', 'Github '),
                        onTap: (value) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('This Number $value')),
                          );
                        },
                      ),
                      ReadMoreXPattern(
                        pattern: r'https://',
                        onTap: (value) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('This Link $value')),
                          );
                        },
                      ),
                      ReadMoreXPattern(
                        pattern: r'\b[0-9]{9,}\b',
                        colorChanged: Colors.red,
                        onTap: (value) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('This Number $value')),
                          );
                        },
                      ),
                      ReadMoreXPattern(
                        pattern: r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b',
                        colorChanged: Colors.deepPurple,
                        onTap: (value) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('This Email $value')),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                if (post.imagePost.isNotEmpty) Image.asset(post.imagePost),
              ],
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text.rich(
              TextSpan(
                children: <InlineSpan>[
                  const TextSpan(text: 'Liked by '),
                  TextSpan(text: '${post.likePost.first} ', style: const TextStyle(fontWeight: FontWeight.w600)),
                  if (post.likePost.length > 1) const TextSpan(text: 'and '),
                  if (post.likePost.length > 1)
                    TextSpan(
                      text: '${post.likePost.length - 1} Others',
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                ],
              ),
            ),
          ),
          Row(
            children: <Widget>[
              const Icon(CupertinoIcons.ellipses_bubble, size: 20),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () => setState(() {
                  isFavorite = !isFavorite;
                  if (isFavorite) {
                    post.likePost.insert(0, 'You');
                    post = post.copyWith(likePost: post.likePost);
                  } else {
                    post.likePost.remove('You');
                    post = post.copyWith(likePost: post.likePost);
                  }
                }),
                child: Icon(
                  isFavorite ? CupertinoIcons.heart_fill : CupertinoIcons.heart,
                  color: isFavorite ? Colors.green : Colors.black,
                  size: isFavorite ? 22 : 20,
                ),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.send_rounded, size: 20),
              Expanded(
                child: Text(
                  '${post.commentPost.length} Comments',
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          ),
          const Divider(),
        ],
      ),
    );
  }

  String get _postCreateAt {
    String result = '';
    DateTimeRange durationRange = DateTimeRange(start: post.createAt, end: DateTime.now());

    if (durationRange.duration.inMinutes >= 1440) {
      result = '${durationRange.duration.inDays} day ago';
    } else if (durationRange.duration.inMinutes >= 60) {
      result = '${durationRange.duration.inHours} hours ago';
    } else if (durationRange.duration.inMinutes <= 60) {
      result = '${durationRange.duration.inMinutes} minutes ago';
    } else {
      result = '${durationRange.duration.inSeconds} seconds ago';
    }
    return result;
  }
}
