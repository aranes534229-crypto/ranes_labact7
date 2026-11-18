import 'package:flutter/material.dart';
import 'post.dart';

// A bottom sheet form that lets the user create a new post and returns it to the caller.
class CreatePostSheet extends StatefulWidget {
  // The username of the student creating the post.
  final String username;

  const CreatePostSheet({
    super.key,
    required this.username,
  });

  @override
  State<CreatePostSheet> createState() => _CreatePostSheetState();
}

class _CreatePostSheetState extends State<CreatePostSheet> {
  // Controller for the multi-line post content field.
  final contentController = TextEditingController();

  // Inline validation message shown below the field.
  String? errorMessage;

  // Validates the content is not empty and returns the new Post via Navigator.pop.
  void submitPost() {
    final String content = contentController.text.trim();

    if (content.isEmpty) {
      setState(() {
        errorMessage = 'Post content cannot be empty.';
      });
      return;
    }

    setState(() {
      errorMessage = null;
    });

    final newPost = Post(
      username: widget.username,
      content: content,
      createdAt: DateTime.now(),
    );

    Navigator.pop(context, newPost);
  }

  @override
  void dispose() {
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        // MediaQuery.of(context).viewInsets.bottom adds padding for the keyboard
        // so the Post button stays visible when the keyboard opens.
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Create Post',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: contentController,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: 'What\'s on your mind?',
                prefixIcon: Icon(Icons.edit),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            if (errorMessage != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  errorMessage!,
                  style: const TextStyle(color: Colors.red, fontSize: 13),
                  textAlign: TextAlign.center,
                ),
              ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: submitPost,
              child: const Text('Post'),
            ),
          ],
        ),
      ),
    );
  }
}
