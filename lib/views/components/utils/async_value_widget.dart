import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone_course/views/components/animations/loading_animation_view.dart';
import 'package:instagram_clone_course/views/components/animations/small_error_animation_view.dart';

class AsyncValueWidget<T> extends StatelessWidget {
  const AsyncValueWidget(
      {Key? key, required this.value, required this.data, this.loadingWidget})
      : super(key: key);

  final AsyncValue<T> value;
  final Widget Function(T) data;
  final Widget? loadingWidget;

  @override
  Widget build(BuildContext context) {
    return value.when(
      data: data,
      loading: () => this.loadingWidget == null
          ? const LoadingAnimationView()
          : loadingWidget!,
      error: (e, _) => const SmallErrorAnimationView(),
    );
  }
}
