import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nanumi/models/comment.dart';
import 'package:nanumi/repositories/comment_repository.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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
  return await _firestore
      .collection('comments')
      .doc('${comment.id}-${comment.deviceId}')
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

    // Firestore 문서 목록 스트림
    _repository.listenCommentStream(id).listen((event) async {
      totalCount = await _repository.commentTotalCount(id);
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
