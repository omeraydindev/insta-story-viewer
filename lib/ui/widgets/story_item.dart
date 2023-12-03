import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:insta_story_viewer/models/story.dart';
import 'package:insta_story_viewer/ui/pages/view_video.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';

class StoryItem extends HookWidget {
  const StoryItem({Key? key, required this.story}) : super(key: key);

  final Story story;

  @override
  Widget build(BuildContext context) {
    final preview = story.thumbnail.isNotEmpty
        ? PlayableStory(story: story)
        : story.mediaType == MediaType.image
            ? story.source.isNotEmpty
                ? Image.network(story.source)
                : const Icon(Icons.image)
            : const Icon(Icons.video_library);

    return Column(
      children: [
        preview,
        const SizedBox(height: 8),
        Text(story.takenAt),
        const SizedBox(height: 8),
      ],
    );
  }
}

class PlayableStory extends HookWidget {
  const PlayableStory({Key? key, required this.story}) : super(key: key);

  final Story story;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.network(story.thumbnail),
        Positioned.fill(
          child: Align(
            alignment: Alignment.center,
            child: IconButton(
              icon: const Icon(
                Icons.play_arrow,
                color: Colors.white,
                size: 56,
              ),
              onPressed: () {
                Navigator.of(context).push(SwipeablePageRoute(
                  builder: (context) => ViewVideoPage(
                    videoUrl: story.source,
                  ),
                ));
              },
            ),
          ),
        ),
      ],
    );
  }
}
