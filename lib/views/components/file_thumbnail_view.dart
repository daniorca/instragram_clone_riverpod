import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../state/image_upload/models/image_with_aspect_ratio.dart';
import '../../state/image_upload/models/thumbnail_request.dart';
import '../../state/image_upload/providers/thumbnail_provider.dart';
import 'utils/async_value_widget.dart';

class FileThumbnailView extends ConsumerWidget {
  final ThumbnailRequest thumbnailRequest;

  const FileThumbnailView({
    super.key,
    required this.thumbnailRequest,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncValue = ref.watch(thumbnailProvider(thumbnailRequest));
    return AsyncValueWidget<ImageWithAspectRatio>(
      value: asyncValue,
      data: (imageWithAspectRatio) {
        return AspectRatio(
          aspectRatio: imageWithAspectRatio.aspectRatio,
          child: imageWithAspectRatio.image,
        );
      },
    );
  }
}
