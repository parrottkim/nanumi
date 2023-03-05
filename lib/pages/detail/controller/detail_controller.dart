import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nanumi/models/comment.dart';
import 'package:nanumi/models/organization.dart';
import 'package:nanumi/pages/organization/controller/organization_controller.dart';
import 'package:nanumi/providers/device_info_provider.dart';
import 'package:nanumi/repositories/comment_repository.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

final detailProvider =
    StreamProvider.family<Organization, String>((ref, id) async* {
  final list = ref.watch(listProvider).value!;
  late Organization organization;

  for (var element in list) {
    if (element.id == id) {
      organization = element;
    }
  }
  yield organization;
});

final commentProvider =
    StateNotifierProvider<CommentNotifier, String>((ref) => CommentNotifier());

class CommentNotifier extends StateNotifier<String> {
  CommentNotifier() : super('');

  set value(String text) => state = text;
}

final agreementProvider =
    StateNotifierProvider.autoDispose<AgreementNotifier, bool>(
        (ref) => AgreementNotifier());

class AgreementNotifier extends StateNotifier<bool> {
  AgreementNotifier() : super(false);

  set value(bool flag) => state = flag;
}

final addCommentProvider =
    FutureProvider.family<void, Comment>((ref, comment) async {
  await _firestore.collection('organizations').doc(comment.id).set({
    'recentComment': comment.toJson(),
  }, SetOptions(merge: true));
  await _firestore
      .collection('organizations')
      .doc(comment.id)
      .collection('comments')
      .doc(comment.deviceId)
      .set(comment.toJson());
});

final commentListProvider = StateNotifierProvider.family<
    CommentListNotifier,
    AsyncValue<List<Comment>>,
    String>((ref, id) => CommentListNotifier(ref: ref, id: id));

class CommentListNotifier extends StateNotifier<AsyncValue<List<Comment>>> {
  CommentListNotifier({required this.ref, required this.id})
      : super(AsyncLoading()) {
    _fetchFirestoreData();
    controller.addListener(() => _scrollListeners());
  }

  final ScrollController controller = ScrollController();
  final CommentRepository _repository = CommentRepository();

  final Ref ref;
  final String id;

  bool _isLoading = false;
  int totalCount = 0;

  _fetchFirestoreData() async {
    if (_isLoading) return;
    _isLoading = true;

    totalCount = await _repository.commentTotalCount(id);
    if (totalCount == 0) {
      state = AsyncValue.data([]);
    }

    _repository.listenCommentStream(id).listen((event) async {
      state = AsyncValue.data(event);
    });

    _isLoading = false;
  }

  _scrollListeners() async {
    final reachMaxExtent =
        controller.offset >= controller.position.maxScrollExtent - 20.0;
    final outOfRange =
        !controller.position.outOfRange && controller.position.pixels != 0;
    if (reachMaxExtent && outOfRange) {
      await _fetchFirestoreData();
    }
  }

  refresh() async {
    state = AsyncLoading();
    await _fetchFirestoreData();
  }
}

// final likedProvider =
//     FutureProvider.family<bool, Organization>((ref, organization) async {
//   final info = ref.watch(deviceInfoProvider);
//   var snapshot = await _firestore
//       .collection('organizations')
//       .doc(organization.id)
//       .collection('likes')
//       .where(info[1])
//       .count()
//       .get();
//   return snapshot.count > 0;
// });

final likedProvider =
    StateNotifierProvider.family<LikedNotifier, bool, Organization>(
        (ref, organization) =>
            LikedNotifier(ref: ref, organization: organization));

class LikedNotifier extends StateNotifier<bool> {
  LikedNotifier({required this.ref, required this.organization})
      : super(false) {
    _fetchFirestoreData();
  }

  final Ref ref;
  final Organization organization;

  _fetchFirestoreData() async {
    final info = ref.watch(deviceInfoProvider);
    _firestore
        .collection('organizations')
        .doc(organization.id)
        .collection('likes')
        .where(info[1])
        .snapshots()
        .listen((event) {
      if (event.docs.isNotEmpty) {
        for (var doc in event.docs) {
          if (doc['id'] == info[1]) {
            state = true;
          }
        }
      }
    });
  }

  toggleLiked(bool flag) async {
    final info = ref.watch(deviceInfoProvider);
    if (flag) {
      state = false;
      await _firestore.collection('organizations').doc(organization.id).set(
        {
          'likes': FieldValue.increment(-1),
        },
        SetOptions(merge: true),
      );
      await _firestore
          .collection('organizations')
          .doc(organization.id)
          .collection('likes')
          .doc(info[1])
          .delete();
    } else {
      state = true;
      await _firestore.collection('organizations').doc(organization.id).set(
        {
          'likes': FieldValue.increment(1),
        },
        SetOptions(merge: true),
      );
      await _firestore
          .collection('organizations')
          .doc(organization.id)
          .collection('likes')
          .doc(info[1])
          .set({
        'id': info[1],
        'createdAt': DateTime.now(),
      });
    }
  }
}
