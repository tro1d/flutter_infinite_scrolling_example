import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scrolling_example/services/story_services.dart';
import 'package:infinite_scrolling_example/utils/generate_random_post.dart';

class StoryCardHorizontal extends StatelessWidget {
  const StoryCardHorizontal({Key? key, required this.service}) : super(key: key);

  final StoryNotifier service;

  @override
  Widget build(BuildContext context) {
    const double fBoxSize = 60.0;
    return Column(
      children: <Widget>[
        ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: fBoxSize + 24),
          child: ListenableBuilder(
            listenable: service,
            builder: (context, child) => ListView(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              controller: service.scrollStoryCTRL,
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                storyCard(
                  label: 'New Story',
                  fBoxSize: fBoxSize,
                  child: const Icon(Icons.add_a_photo),
                ),
                ...List.generate(
                  service.storyList.length + 1,
                  (index) {
                    if (index < service.storyList.length) {
                      return storyCard(
                        label: HiImFay().listName[Random().nextInt(14)],
                        fBoxSize: fBoxSize,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(fBoxSize),
                          child: Image.asset(
                            height: fBoxSize - 2,
                            width: fBoxSize - 2,
                            service.storyList[index],
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    }
                    if (service.storyList.isEmpty && service.hasLimitStory) {
                      return storyCard(
                        label: 'Empty',
                        fBoxSize: fBoxSize,
                        child: const Center(child: Icon(CupertinoIcons.person_crop_circle_fill_badge_xmark)),
                      );
                    } else {
                      if (!service.hasLimitStory) {
                        return storyCard(
                          label: '',
                          fBoxSize: fBoxSize,
                          child: const Center(child: CircularProgressIndicator()),
                        );
                      } else {
                        return GestureDetector(
                          onTap: service.onStoryReload,
                          child: storyCard(
                            label: '',
                            fBoxSize: fBoxSize,
                            child: const Icon(Icons.refresh),
                          ),
                        );
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ),
        const Divider(),
      ],
    );
  }

  Widget storyCard({required String label, required double fBoxSize, required Widget child}) {
    return Column(
      children: <Widget>[
        Container(
          constraints: BoxConstraints(maxHeight: fBoxSize, maxWidth: fBoxSize),
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(horizontal: 2.0),
          decoration: BoxDecoration(
            color: Colors.green.shade300,
            shape: BoxShape.circle,
            boxShadow: const [BoxShadow(offset: Offset(2.0, 2.0), blurRadius: 2.0, color: Colors.black38)],
          ),
          child: child,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: SizedBox(
            width: fBoxSize,
            child: Text(
              label,
              style: const TextStyle(fontSize: 12.0),
              maxLines: 1,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}
