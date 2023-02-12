import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nanumi/models/comment.dart';

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
  final doc = await _firestore
      .collection('organizations')
      .doc(comment.id)
      .collection('likes')
      .doc(comment.deviceId)
      .get();
  if (!doc.exists) {
    _firestore
        .collection('organizations')
        .doc(comment.id)
        .set({'likes': FieldValue.increment(1)}, SetOptions(merge: true));
  }
  return await _firestore
      .collection('organizations')
      .doc(comment.id)
      .collection('likes')
      .doc(comment.deviceId)
      .set(comment.toJson());
});

final commentListProvider =
    StateNotifierProvider.family<CommentListNotifier, List<Comment>, String>(
        (ref, id) => CommentListNotifier(ref: ref, id: id));

class CommentListNotifier extends StateNotifier<List<Comment>> {
  CommentListNotifier({required this.ref, required this.id}) : super([]) {
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
        .limit(10);

    if (state.isEmpty) {
      documents = await query.get();
    } else {
      documents =
          await query.startAfterDocument(_lastDocuments).limit(10).get();
    }
    _lastDocuments = documents.docs.last;
    _isLoading = false;

    if (mounted) {
      return state = [
        ...state,
        ...documents.docs
            .map<Comment>((element) => Comment.fromFirestore(element)),
      ];
    }
  }
}
