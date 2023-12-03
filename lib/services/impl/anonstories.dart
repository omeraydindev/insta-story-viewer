import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:insta_story_viewer/main.dart';
import 'package:insta_story_viewer/models/result.dart';
import 'package:insta_story_viewer/models/story.dart';
import 'package:insta_story_viewer/services/story_service.dart';

// anonstories.com unofficial API
class AnonStoriesStoryService extends StoryService {
  @override
  Future<Result<List<Story>>> getStories({
    required String username,
  }) async {
    const url = 'https://anonstories.com/api/v1/story';
    final options = Options(
      contentType: 'application/x-www-form-urlencoded',
    );

    final authKey = '-1::$username::rJP2tBRKf6ktbRqPUBtRE9klgBWb7d';
    final auth = base64Encode(utf8.encode(authKey))
        .replaceAll('+', '.')
        .replaceAll('/', '_')
        .replaceAll('=', '-');

    final payload = {
      'auth': auth,
    };

    try {
      final dioResult = await dio.post(url, options: options, data: payload);

      final data = dioResult.data as Map<String, dynamic>;
      final storiesData = data['stories'] as List<dynamic>? ?? [];

      final stories = storiesData.map((storyData) {
        final mediaType = storyData['media_type'] as String? ?? '';
        final source = storyData['source'] as String? ?? '';
        final thumbnail = storyData['thumbnail'] as String? ?? '';
        final takenAt = storyData['taken_at'] as String? ?? '';

        return Story(
          mediaType: mediaType == 'image' ? MediaType.image : MediaType.video,
          source: source,
          thumbnail: thumbnail,
          takenAt: takenAt,
        );
      }).toList();

      return Result.success(stories);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }
}
