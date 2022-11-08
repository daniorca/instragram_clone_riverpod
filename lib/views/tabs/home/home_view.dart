import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_course/state/posts/providers/all_posts_provider.dart';
import 'package:instagram_clone_course/views/components/animations/empty_contents_with_text_animation_view.dart';
import 'package:instagram_clone_course/views/components/post/posts_grid_view.dart';
import 'package:instagram_clone_course/views/components/utils/async_value_widget.dart';
import 'package:instagram_clone_course/views/constants/strings.dart';

import '../../../state/posts/models/post.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final posts = ref.watch(allPostsProvider);

    return RefreshIndicator(
      onRefresh: () {
        ref.refresh(allPostsProvider);
        return Future.delayed(const Duration(seconds: 1));
      },
      child: AsyncValueWidget<Iterable<Post>>(
          value: posts,
          data: (posts) {
            if (posts.isEmpty) {
              return EmptyContentsWithTextAnimationView(
                  text: Strings.noPostsAvailable);
            }
            return PostsGridView(posts: posts);
          }),
    );
  }
}
