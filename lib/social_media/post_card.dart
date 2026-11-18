import 'package:flutter/material.dart';
import 'post.dart';

// A card showing one post: author avatar, username, content, timestamp, like
// button with count, comment field, and the post's comment list. Likes and
// comments stay attached to the correct post via its key.
class PostCard extends StatefulWidget {
  final Post post;

  const PostCard({super.key, required this.post});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  // Controller for the comment text field.
  final commentController = TextEditingController();

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }

  // Toggles the like state of this post.
  void likePost() {
    setState(() {
      widget.post.isLiked = !widget.post.isLiked;
      if (widget.post.isLiked) {
        widget.post.likes++;
      } else {
        widget.post.likes--;
      }
    });
  }

  // Adds a non-empty comment to THIS post's comments list.
// Post.comments is now a mutable List<String> (not const []), so add() works.
// Calls setState() so the comment count and comment text rebuild, then clears the field.
  void addComment() {
    final String comment = commentController.text.trim();

    if (comment.isEmpty) {
      return;
    }

    setState(() {
      widget.post.comments.add(comment);
    });

    commentController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 16),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.indigo,
              child: Text(
                widget.post.username.isNotEmpty
                    ? widget.post.username[0].toUpperCase()
                    : '?',
                style: const TextStyle(color: Colors.white),
              ),
            ),
            title: Text(
              widget.post.username,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              widget.post.createdAt.toString().substring(0, 16),
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              widget.post.content,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          Row(
            children: [
              TextButton.icon(
                onPressed: likePost,
                icon: Icon(
                  widget.post.isLiked ? Icons.favorite : Icons.favorite_border,
                  color: widget.post.isLiked ? Colors.red : null,
                ),
                label: Text('${widget.post.likes} Likes'),
              ),
              const SizedBox(width: 16),
              TextButton.icon(
                onPressed: addComment,
                icon: const Icon(Icons.comment),
                label: Text('${widget.post.comments.length} Comments'),
              ),
            ],
          ),
          for (final String comment in widget.post.comments)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(comment),
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: commentController,
                    onSubmitted: (_) => addComment(), // Pressing Enter also adds the comment
                    decoration: const InputDecoration(
                      hintText: 'Add a comment...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: addComment,
                  icon: const Icon(Icons.send),
                  color: Colors.indigo,
                  tooltip: 'Send comment',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
