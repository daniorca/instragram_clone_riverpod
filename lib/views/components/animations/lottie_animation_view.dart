import 'package:flutter/material.dart';
import 'package:instagram_clone_course/views/components/animations/models/lottie_animation.dart';
import 'package:lottie/lottie.dart';

class LottieAnimationView extends StatelessWidget {
  final LottieAnimation animation;
  final bool repeat;
  final bool reverse;
  const LottieAnimationView({
    Key? key,
    required this.animation,
    this.repeat = true,
    this.reverse = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Lottie.asset(
        animation.fullPath,
        reverse: this.reverse,
        repeat: this.repeat,
      );
}

extension GetFullPath on LottieAnimation {
  String get fullPath => 'assets/animations/$name.json';
}
