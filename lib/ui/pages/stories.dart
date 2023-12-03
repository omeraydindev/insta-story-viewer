import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:insta_story_viewer/main.dart';
import 'package:insta_story_viewer/models/story.dart';
import 'package:insta_story_viewer/ui/widgets/story_item.dart';

class StoriesPage extends HookWidget {
  const StoriesPage({
    Key? key,
    required this.username,
  }) : super(key: key);

  final String username;

  @override
  Widget build(BuildContext context) {
    final isLoading = useState(true);
    final stories = useState(<Story>[]);
    final error = useState<String?>(null);

    void fetchStories() {
      isLoading.value = true;
      storyService.getStories(username: username).then((value) {
        if (value.hasError) {
          error.value = value.errorMessage;
        } else {
          stories.value = value.data ?? [];
        }
      }).catchError((e) {
        error.value = e.toString();
      }).whenComplete(() {
        isLoading.value = false;
      });
    }

    useEffect(() {
      fetchStories();
      return null;
    }, [username]);

    return Scaffold(
      appBar: AppBar(
        title: Text(username),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Theme.of(context).primaryColor,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Builder(
          builder: (context) {
            if (isLoading.value) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (stories.value.isEmpty) {
              return const Center(
                child: Text('No stories found for this user'),
              );
            }

            if (error.value != null) {
              return Center(
                child: Text(error.value!),
              );
            }

            return ListView.builder(
              itemCount: stories.value.length,
              itemBuilder: (context, index) {
                final story = stories.value[index];
                return StoryItem(story: story);
              },
            );
          },
        ),
      ),
    );
  }
}
