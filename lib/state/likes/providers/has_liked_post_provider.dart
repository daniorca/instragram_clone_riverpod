import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../auth/providers/user_id_provider.dart';
import '../../constants/firebase_collection_name.dart';
import '../../constants/firebase_field_name.dart';
import '../../posts/typedefs/post_id.dart';

final hasLikedProvider =
    StreamProvider.family.autoDispose<bool, PostId>((ref, PostId postId) {
  final userId = ref.watch(userIdProvider);
  if (userId == null) {
    return Stream<bool>.value(false);
  }

  final controller = StreamController<bool>();

  final sub = FirebaseFirestore.instance
      .collection(FirebaseCollectionName.likes)
      .where(FirebaseFieldName.postId, isEqualTo: postId)
      .where(FirebaseFieldName.userId, isEqualTo: userId)
      .snapshots()
      .listen(
    (snapshot) {
      controller.add(snapshot.docs.isNotEmpty);
    },
  );

  ref.onDispose(() {
    sub.cancel();
    controller.close();
  });

  return controller.stream;
});
