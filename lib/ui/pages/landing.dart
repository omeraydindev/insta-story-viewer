import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:insta_story_viewer/ui/pages/stories.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';

class LandingPage extends HookWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final usernameController = useTextEditingController();

    void goToStoriesPage() {
      if (usernameController.text.isEmpty) {
        return;
      }

      Navigator.of(context).push(SwipeablePageRoute(
        builder: (context) => StoriesPage(
          username: usernameController.text,
        ),
      ));
    }

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Insta Story Viewer',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: 300,
              child: TextField(
                controller: usernameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Username',
                  hintText: 'seymasubasi',
                ),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: goToStoriesPage,
              child: const Text('View Stories'),
            ),
          ],
        ),
      ),
    );
  }
}
