import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:insta_story_viewer/services/impl/anonstories.dart';
import 'package:insta_story_viewer/services/story_service.dart';
import 'package:insta_story_viewer/ui/pages/landing.dart';

final dio = Dio();
final StoryService storyService = AnonStoriesStoryService();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Insta Story Viewer',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const LandingPage(),
    );
  }
}
