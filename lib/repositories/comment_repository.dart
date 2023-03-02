import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nanumi/models/comment.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final StreamController<List<Comment>> _streamController =
    StreamController<List<Comment>>.broadcast();

class CommentRepository {
  List<List<Comment>> _comments = [];
  DocumentSnapshot? _lastDocument;

  Stream<List<Comment>> listenCommentStream(String id) {
    fetchRecentList(id);
    return _streamController.stream;
  }

  void fetchRecentList(String id, [int limit = 20]) {
    var query = _firestore
        .collection('comments')
        .where('id', isEqualTo: id)
        .orderBy('createdAt', descending: true)
        .limit(limit);
    List<Comment> results = [];

    if (_lastDocument != null) {
      query = query.startAfterDocument(_lastDocument!);
    }

    var currentRequestIndex = _comments.length;

    query.snapshots().listen((event) {
      if (event.docs.isNotEmpty) {
        var comments = event.docs
            .map((element) => Comment.fromFirestore(element))
            .toList();

        var pageExists = currentRequestIndex < _comments.length;

        if (pageExists) {
          _comments[currentRequestIndex] = comments;
        } else {
          _comments.add(comments);
        }

        results = _comments.fold<List<Comment>>(
            [], (initialValue, pageItems) => initialValue..addAll(pageItems));

        _streamController.add(results);
      }

      if (event.docs.isEmpty && event.docChanges.isNotEmpty) {
        for (final data in event.docChanges) {
          if (data.newIndex == -1) {
            results.removeWhere((element) => element == data.doc.data()?['id']);
          }
        }
        _streamController.add(results);
      }

      // 마지막 문서 지정
      if (results.isNotEmpty && currentRequestIndex == _comments.length - 1) {
        _lastDocument = event.docs.last;
      }
    });
  }

  Future<int> commentTotalCount(String id) async {
    AggregateQuerySnapshot query = await _firestore
        .collection('comments')
        .where('id', isEqualTo: id)
        .orderBy('createdAt', descending: true)
        .count()
        .get();
    return query.count;
  }
}
