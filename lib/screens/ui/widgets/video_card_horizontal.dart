import 'dart:math';

import 'package:flutter/material.dart';
import 'package:infinite_scrolling_example/services/video_services.dart';
import 'package:infinite_scrolling_example/utils/generate_random_post.dart';

class VideoCardHorizontal extends StatelessWidget {
  const VideoCardHorizontal({Key? key, required this.service}) : super(key: key);

  final VideoNotifier service;

  @override
  Widget build(BuildContext context) {
    const double fBoxSize = 160.0;
    return ListenableBuilder(
      listenable: service,
      builder: (context, child) => Visibility(
        visible: service.isVideosVisible,
        replacement: Align(
          alignment: Alignment.topRight,
          child: TextButton.icon(
            style: const ButtonStyle(overlayColor: MaterialStatePropertyAll(Colors.transparent)),
            onPressed: service.onVideoVisibile,
            icon: const Text('Show Top Videos'),
            label: const Icon(Icons.remove_red_eye_outlined),
          ),
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      'Top Videos',
                      style: TextStyle(
                        color: Colors.green.shade800,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: service.onVideoVisibile,
                    child: const Icon(Icons.close),
                  ),
                ],
              ),
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: fBoxSize),
              child: ListView.builder(
                controller: service.scrollVideosCTRL,
                scrollDirection: Axis.horizontal,
                itemCount: service.videoList.length + 1,
                itemBuilder: (context, index) {
                  if (index < service.videoList.length) {
                    return videoCard(
                      fBoxSize: fBoxSize,
                      child: Stack(
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16.0),
                            child: Image.asset(
                              height: fBoxSize,
                              width: fBoxSize,
                              service.videoList[index],
                              fit: BoxFit.cover,
                            ),
                          ),
                          const Center(
                            child: Icon(
                              Icons.play_arrow_rounded,
                              size: fBoxSize * 0.5,
                              color: Color(0x892E522F),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                width: fBoxSize,
                                child: Text(
                                  '${HiImFay().listName[Random().nextInt(14)]} - ${service.videoList[index]}',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    shadows: <Shadow>[
                                      BoxShadow(offset: Offset(2.0, 2.0), blurRadius: 2.0, color: Colors.black54),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  }
                  if (service.videoList.isEmpty && service.hasLimitVideo) {
                    return videoCard(
                      fBoxSize: fBoxSize,
                      child: const Center(child: Text('Empty')),
                    );
                  } else {
                    if (!service.hasLimitVideo) {
                      return videoCard(
                        fBoxSize: fBoxSize,
                        child: const CircularProgressIndicator(),
                      );
                    } else {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(shape: const CircleBorder()),
                            onPressed: service.onVideoReload,
                            child: const Icon(Icons.refresh),
                          ),
                        ),
                      );
                    }
                  }
                },
              ),
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }

  Widget videoCard({required double fBoxSize, required Widget child}) {
    return Container(
      constraints: BoxConstraints(maxHeight: fBoxSize, maxWidth: fBoxSize),
      alignment: Alignment.center,
      margin: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: Colors.green.shade300,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: const <BoxShadow>[
          BoxShadow(offset: Offset(2.0, 2.0), blurRadius: 2.0, color: Colors.black38),
        ],
      ),
      child: child,
    );
  }
}
