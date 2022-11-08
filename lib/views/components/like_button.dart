import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../state/auth/providers/user_id_provider.dart';
import '../../state/likes/models/like_dislike_request.dart';
import '../../state/likes/providers/has_liked_post_provider.dart';
import '../../state/likes/providers/like_dislike_post_provider.dart';
import '../../state/posts/typedefs/post_id.dart';
import 'utils/async_value_widget.dart';

class LikeButton extends ConsumerWidget {
  final PostId postId;
  const LikeButton({super.key, required this.postId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncHasLiked = ref.watch(hasLikedProvider(postId));
    return AsyncValueWidget<bool>(
      value: asyncHasLiked,
      data: (hasLiked) {
        return IconButton(
          onPressed: () {
            final userId = ref.read(userIdProvider);
            if (userId == null) {
              return;
            }
            final likeRequest =
                LikeDislikeRequest(postId: postId, likedBy: userId);
            ref.read(likeDislikePostProvider(likeRequest));
          },
          icon: FaIcon(
              hasLiked ? FontAwesomeIcons.solidHeart : FontAwesomeIcons.heart),
        );
      },
      loadingWidget: const Center(child: CircularProgressIndicator()),
    );
  }
}
