import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_course/state/likes/providers/post_likes_count_provider.dart';
import 'package:instagram_clone_course/state/posts/typedefs/post_id.dart';
import 'package:instagram_clone_course/views/components/constants/strings.dart';
import 'package:instagram_clone_course/views/components/utils/async_value_widget.dart';
import 'package:intl/intl.dart';

class LikesCountView extends ConsumerWidget {
  final PostId postId;
  const LikesCountView({super.key, required this.postId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncLikesCount = ref.watch(postLikesCountProvider(postId));
    return AsyncValueWidget<int>(
        value: asyncLikesCount,
        data: (likesCount) {
          final likesText =
              '$likesCount ${Intl.plural(likesCount, one: Strings.person, other: Strings.people)} ${Strings.likedThis}';
          return Text(likesText);
        });
  }
}
