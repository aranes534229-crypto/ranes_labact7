// A single social media post created by a student.
class Post {
  // The username of the student who created this post.
  final String username;

  // The text content of the post.
  final String content;

  // The date and time when the post was created.
  final DateTime createdAt;

  // The number of likes this post has received.
  int likes;

  // Whether the currently logged-in student has liked this post.
  bool isLiked;

  // The list of comments on this post. Mutable so comments can be added.
  List<String> comments;

  Post({
    required this.username,
    required this.content,
    required this.createdAt,
    this.likes = 0,
    this.isLiked = false,
    List<String>? comments,
  }) : comments = comments ?? <String>[];
}
