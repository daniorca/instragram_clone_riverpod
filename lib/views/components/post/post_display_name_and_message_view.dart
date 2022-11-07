import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_course/state/posts/models/post.dart';
import 'package:instagram_clone_course/state/user_info/providers/user_info_model_provider.dart';
import 'package:instagram_clone_course/views/components/rich_two_parts_text.dart';
import 'package:instagram_clone_course/views/components/utils/async_value_widget.dart';

import '../../../state/user_info/models/user_info_model.dart';

class PostDisplayNameAbdMessageView extends ConsumerWidget {
  final Post post;
  const PostDisplayNameAbdMessageView({super.key, required this.post});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncUserInfoModel = ref.watch(userInfoModelProvider(post.userId));
    return AsyncValueWidget<UserInfoModel>(
      value: asyncUserInfoModel,
      data: (userInfoModel) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: RichTwoPartsText(
            leftPart: userInfoModel.displayName,
            rightPart: post.message,
          ),
        );
      },
    );
  }
}
