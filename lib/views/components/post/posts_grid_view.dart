import 'package:flutter/material.dart';
import 'package:instagram_clone_course/state/posts/models/post.dart';
import 'package:instagram_clone_course/views/components/post/post_thumbnail.dart';
import 'package:instagram_clone_course/views/post_comments/post_comments_view.dart';

class PostsGridView extends StatelessWidget {
  final Iterable<Post> posts;
  const PostsGridView({Key? key, required this.posts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        padding: EdgeInsets.all(8),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
        ),
        itemCount: posts.length,
        itemBuilder: (context, index) {
          final post = posts.elementAt(index);
          return PostThumbnailView(
            post: post,
            onTapped: () {
              //TODO: remove this code before we go to details view
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => PostCommentsView(postId: post.postId),
                ),
              );
              //TODO: navigate to the post details view
            },
          );
        });
  }
}
