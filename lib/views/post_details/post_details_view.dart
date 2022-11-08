import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_course/enums/date_sorting.dart';
import 'package:instagram_clone_course/state/comments/models/post_comment_request.dart';
import 'package:instagram_clone_course/state/posts/models/post.dart';
import 'package:instagram_clone_course/state/posts/providers/can_current_user_delete_post_provider.dart';
import 'package:instagram_clone_course/state/posts/providers/delete_post_provider.dart';
import 'package:instagram_clone_course/state/posts/providers/specific_post_with_comments_provider.dart';
import 'package:instagram_clone_course/views/components/comments/compact_comment_column.dart';
import 'package:instagram_clone_course/views/components/dialogs/alert_dialog_model.dart';
import 'package:instagram_clone_course/views/components/dialogs/delete_dialog.dart';
import 'package:instagram_clone_course/views/components/like_button.dart';
import 'package:instagram_clone_course/views/components/likes_count_view.dart';
import 'package:instagram_clone_course/views/components/post/post_date_view.dart';
import 'package:instagram_clone_course/views/components/post/post_display_name_and_message_view.dart';
import 'package:instagram_clone_course/views/components/post/post_image_or_video.view.dart';
import 'package:instagram_clone_course/views/components/utils/async_value_widget.dart';
import 'package:instagram_clone_course/views/constants/strings.dart';
import 'package:instagram_clone_course/views/post_comments/post_comments_view.dart';
import 'package:share_plus/share_plus.dart';

import '../../state/comments/models/post_with_comments.dart';

class PostDetailsView extends ConsumerStatefulWidget {
  final Post post;
  const PostDetailsView({super.key, required this.post});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PostDetailsViewState();
}

class _PostDetailsViewState extends ConsumerState<PostDetailsView> {
  @override
  Widget build(BuildContext context) {
    final request = RequestForPostAndComments(
        postId: widget.post.postId,
        limit: 3,
        sortByCreatedAt: true,
        dateSorting: DateSorting.oldestOnTop);

    //get the actual post together with its comments
    final postWithComments =
        ref.watch(specificPostWithCommentsProvider(request));

    //can we delete this post?
    final canDeletePost =
        ref.watch(canCurrentUserDeletePostProvider(widget.post));

    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.postDetails),
        actions: [
          //share button is always present
          AsyncValueWidget<PostWithComments>(
            value: postWithComments,
            data: (postWithComments) {
              return IconButton(
                onPressed: () async {
                  final url = postWithComments.post.fileUrl;
                  await Share.share(url, subject: Strings.checkOutThisPost);
                },
                icon: const Icon(Icons.share),
              );
            },
            loadingWidget: const Center(child: CircularProgressIndicator()),
          ),
          //delete button or no delete button if user cannot delete this post
          if (canDeletePost.value ?? false)
            IconButton(
              onPressed: () async {
                final shouldDeletePost = await const DeleteDialog(
                        titleOfObjectToDelete: Strings.post)
                    .present(context)
                    .then((shouldDelete) => shouldDelete ?? false);
                if (shouldDeletePost) {
                  await ref
                      .read(deletePostProvider.notifier)
                      .deletePost(post: widget.post);
                  if (mounted) {
                    Navigator.of(context).pop();
                  }
                }
              },
              icon: Icon(Icons.delete),
            )
        ],
      ),
      body: AsyncValueWidget<PostWithComments>(
          value: postWithComments,
          data: (postWithComments) {
            final postId = postWithComments.post.postId;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  PostImageOrVideoView(post: postWithComments.post),
                  Row(
                    children: <Widget>[
                      // like button if post allows liking
                      if (postWithComments.post.allowLikes)
                        LikeButton(postId: postId),
                      // comment button is post allows commenting on it
                      if (postWithComments.post.allowComments)
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) =>
                                    PostCommentsView(postId: postId),
                              ),
                            );
                          },
                          icon: Icon(Icons.mode_comment_outlined),
                        )
                    ],
                  ),
                  // Post details (show divider at bottom)
                  PostDisplayNameAndMessageView(post: postWithComments.post),
                  PostDateView(dateTime: postWithComments.post.createdAt),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Divider(color: Colors.white70),
                  ),
                  CompactCommentColumn(comments: postWithComments.comments),
                  if (postWithComments.post.allowLikes)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          LikesCountView(postId: postId),
                        ],
                      ),
                    ),
                  // add spacing to bottom of screen
                  const SizedBox(height: 100),
                ],
              ),
            );
          }),
    );
  }
}
