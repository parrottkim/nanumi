import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nanumi/models/comment.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

final inquiryProvider =
    StateNotifierProvider.autoDispose<InquiryNotifier, String>(
        (ref) => InquiryNotifier());

class InquiryNotifier extends StateNotifier<String> {
  InquiryNotifier() : super('');

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
    FutureProvider.family<void, Map<String, dynamic>>((ref, comment) async {
  await _firestore.collection('inquiry').add(comment);
});
