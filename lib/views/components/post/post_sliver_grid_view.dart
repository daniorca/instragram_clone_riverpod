import 'package:flutter/material.dart';
import 'package:instagram_clone_course/views/components/post/post_thumbnail.dart';

import '../../../state/posts/models/post.dart';
import '../../post_details/post_details_view.dart';

class PostsSliverGridView extends StatelessWidget {
  final Iterable<Post> posts;
  const PostsSliverGridView({super.key, required this.posts});

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      delegate: SliverChildBuilderDelegate(childCount: posts.length,
          (context, index) {
        final post = posts.elementAt(index);
        return PostThumbnailView(
          post: post,
          onTapped: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => PostDetailsView(post: post),
              ),
            );
          },
        );
      }),
    );
  }
}
