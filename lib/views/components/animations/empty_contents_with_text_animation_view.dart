import 'package:instagram_clone_course/views/components/animations/empty_contents_animation_view.dart';
import 'package:flutter/material.dart';

class EmptyContentsWithTextAnimationView extends StatelessWidget {
  final String text;
  const EmptyContentsWithTextAnimationView({Key? key, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(32.0),
          child: Text(
            text,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.white54,
                ),
          ),
        ),
        const EmptyContentsAnimationView(),
      ],
    ));
  }
}
