import 'package:flutter/material.dart';
import 'create_post_sheet.dart';
import 'post.dart';
import 'post_card.dart';

// The social media feed page showing a list of posts with a FAB to create new ones.
class SocialMediaPage extends StatefulWidget {
  final String username;

  const SocialMediaPage({super.key, required this.username});

  @override
  State<SocialMediaPage> createState() => _SocialMediaPageState();
}

class _SocialMediaPageState extends State<SocialMediaPage> {
  // The list of posts shown in the feed.
  final List<Post> posts = [];

  // Opens the Create Post form in a bottom sheet and inserts the new post at
  // the top of the feed if one was submitted.
  Future<void> openCreatePostSheet() async {
    final Post? newPost = await showModalBottomSheet<Post>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) {
        return CreatePostSheet(username: widget.username);
      },
    );

    if (!mounted || newPost == null) {
      return;
    }

    setState(() {
      posts.insert(0, newPost);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Social')),
      body: posts.isEmpty
          ? const Center(child: Text('No posts yet. Create one!'))
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: posts.length,
              itemBuilder: (context, index) {
                // ObjectKey(post) keeps this card attached to the correct post
                // so likes and comments stay attached after insertions.
                return PostCard(key: ObjectKey(posts[index]), post: posts[index]);
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: openCreatePostSheet,
        tooltip: 'Create Post',
        child: const Icon(Icons.add),
      ),
    );
  }
}
