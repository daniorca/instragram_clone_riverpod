import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_course/state/comments/models/comment.dart';
import 'package:instagram_clone_course/state/user_info/providers/user_info_model_provider.dart';
import 'package:instagram_clone_course/views/components/rich_two_parts_text.dart';
import 'package:instagram_clone_course/views/components/utils/async_value_widget.dart';

import '../../../state/user_info/models/user_info_model.dart';

class CompactCommentTile extends ConsumerWidget {
  final Comment comment;
  const CompactCommentTile({super.key, required this.comment});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncUserInfo = ref.watch(userInfoModelProvider(comment.fromUserId));
    return AsyncValueWidget<UserInfoModel>(
      value: asyncUserInfo,
      data: (userInfo) {
        return RichTwoPartsText(
            leftPart: userInfo.displayName, rightPart: comment.comment);
      },
    );
  }
}
