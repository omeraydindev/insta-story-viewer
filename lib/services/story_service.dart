import 'package:insta_story_viewer/models/result.dart';
import 'package:insta_story_viewer/models/story.dart';

abstract class StoryService {
  Future<Result<List<Story>>> getStories({
    required String username,
  });
}
