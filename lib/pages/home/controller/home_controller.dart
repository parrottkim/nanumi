import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nanumi/models/comment.dart';
import 'package:nanumi/models/organization.dart';
import 'package:nanumi/models/recent.dart';
import 'package:nanumi/repositories/recent_repository.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

final recentCommentProvider =
    StateNotifierProvider<RecentCommentNotifier, AsyncValue<List<Recent>>>(
        (ref) => RecentCommentNotifier(ref: ref));

class RecentCommentNotifier extends StateNotifier<AsyncValue<List<Recent>>> {
  RecentCommentNotifier({required this.ref}) : super(AsyncLoading()) {
    _fetchFirestoreData();
    controller.addListener(() => _scrollListeners());
  }
  final ScrollController controller = ScrollController();
  final RecentRepository _repository = RecentRepository();

  final Ref ref;

  bool _isLoading = false;
  int totalCount = 0;

  _fetchFirestoreData() async {
    if (_isLoading) return;
    _isLoading = true;

    totalCount = await _repository.commentTotalCount();
    if (totalCount == 0) {
      state = AsyncValue.data([]);
    }

    // Firestore 문서 목록 스트림
    _repository.listenCommentStream().listen((event) async {
      totalCount = await _repository.commentTotalCount();
      for (var comment in event) {
        var organizations =
            _firestore.collection('organizations').doc(comment.id).snapshots();
        organizations.forEach((element) {
          var organization = Organization.fromJson(element.data()!);
          state = AsyncValue.data([
            if (state.value != null) ...state.value!,
            Recent(comment: comment, organization: organization)
          ]);
        });
      }
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
}
