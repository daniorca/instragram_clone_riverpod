import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_course/views/components/post/post_sliver_grid_view.dart';

import '../../state/posts/models/post.dart';
import '../../state/posts/providers/posts_by_search_term_provider.dart';
import '../../state/posts/typedefs/search_term.dart';
import '../constants/strings.dart';
import 'animations/data_not_found_animation_view.dart';
import 'animations/empty_contents_with_text_animation_view.dart';
import 'utils/async_value_widget.dart';

class SearchGridView extends ConsumerWidget {
  final SearchTerm searchTerm;
  const SearchGridView({super.key, required this.searchTerm});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (searchTerm.isEmpty) {
      return const SliverToBoxAdapter(
        child: EmptyContentsWithTextAnimationView(
          text: Strings.enterYourSearchTerm,
        ),
      );
    }

    final posts = ref.watch(postsBySearchTermProvider(searchTerm));

    return AsyncValueWidget<Iterable<Post>>(
      value: posts,
      data: (posts) {
        if (posts.isEmpty) {
          return const SliverToBoxAdapter(
            child: DataNotFoundAnimationView(),
          );
        }
        return PostsSliverGridView(posts: posts);
      },
      loadingWidget: SliverToBoxAdapter(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
