import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nanumi/models/comment.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

final commentListProvider = StateNotifierProvider.family<
    CommentListNotifier,
    AsyncValue<List<Comment>>,
    String>((ref, id) => CommentListNotifier(ref: ref, id: id));

class CommentListNotifier extends StateNotifier<AsyncValue<List<Comment>>> {
  CommentListNotifier({required this.ref, required this.id})
      : super(AsyncLoading()) {
    fetchFirestoreData();
  }

  final Ref ref;
  final String id;

  late QuerySnapshot<Map<String, dynamic>> documents;
  late QueryDocumentSnapshot<Map<String, dynamic>> _lastDocuments;

  bool _isLoading = false;

  fetchFirestoreData() async {
    if (_isLoading) return;
    _isLoading = true;

    final query = _firestore
        .collection('organizations')
        .doc(id)
        .collection('likes')
        .orderBy('date', descending: true)
        .limit(10);

    if (state.value == null) {
      documents = await query.limit(10).get();
    } else {
      documents =
          await query.startAfterDocument(_lastDocuments).limit(10).get();
    }
    if (documents.docs.isNotEmpty) {
      _lastDocuments = documents.docs.last;
    }
    _isLoading = false;

    if (mounted) {
      return state = AsyncValue.data([
        if (state.value != null) ...state.value!,
        ...documents.docs
            .map<Comment>((element) => Comment.fromFirestore(element)),
      ]);
    }
  }

  refresh() async {
    state = AsyncLoading();
    await fetchFirestoreData();
  }
}
