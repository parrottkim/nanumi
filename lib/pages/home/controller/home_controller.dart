import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nanumi/models/comment.dart';
import 'package:nanumi/models/organization.dart';
import 'package:nanumi/models/recent.dart';
import 'package:nanumi/repositories/recent_repository.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

final recentCommentProvider = StreamProvider<List<Recent>>((ref) async* {
  var commentSnapshot = _firestore
      .collection('comments')
      .orderBy('createdAt', descending: true)
      .limit(10)
      .snapshots();
  await for (var comment in commentSnapshot) {
    List<Recent> list = [];
    for (var doc in comment.docs) {
      var organizationSnapshot = await _firestore
          .collection('organizations')
          .doc(doc.data()['id'])
          .get();

      list = [
        ...list,
        Recent(
            comment: Comment.fromFirestore(doc),
            organization: Organization.fromJson(organizationSnapshot.data()!))
      ];
      yield list;
    }
  }
});

// final recentCommentProvider =
//     StateNotifierProvider<RecentCommentNotifier, AsyncValue<List<Recent>>>(
//         (ref) => RecentCommentNotifier(ref: ref));

// class RecentCommentNotifier extends StateNotifier<AsyncValue<List<Recent>>> {
//   RecentCommentNotifier({required this.ref}) : super(AsyncLoading()) {
//     _fetchFirestoreData();
//     controller.addListener(() => _scrollListeners());
//   }
//   final ScrollController controller = ScrollController();
//   final RecentRepository _repository = RecentRepository();

//   final Ref ref;

//   bool _isLoading = false;
//   int totalCount = 0;

//   _fetchFirestoreData() async {
//     final query = await _firestore
//         .collection('comments')
//         .orderBy('createdAt', descending: true)
//         .snapshots();

//     if (mounted) {
//       return state = AsyncValue.data([
//         if (state.value != null) ...state.value!,
//         ...documents.docs.map<Organization>(
//             (element) => Organization.fromFirestore(element)),
//       ]);
//     }
//     // if (_isLoading) return;
//     // _isLoading = true;

//     // totalCount = await _repository.commentTotalCount();
//     // if (totalCount == 0) {
//     //   state = AsyncValue.data([]);
//     // }

//     // _repository.listenCommentStream().listen((event) {
//     //   var list = [];
//     //   for (var comment in event) {
//     //     var organizations =
//     //         _firestore.collection('organizations').doc(comment.id).snapshots();
//     //     organizations.forEach((element) {
//     //       var organization = Organization.fromJson(element.data()!);
//     //       list.add(Recent(comment: comment, organization: organization));
//     //     });
//     //   }
//     //   state = AsyncValue.data([
//     //     ...list,
//     //   ]);
//     // });

//     // _isLoading = false;
//   }

//   _scrollListeners() async {
//     final reachMaxExtent =
//         controller.offset >= controller.position.maxScrollExtent - 20.0;
//     final outOfRange =
//         !controller.position.outOfRange && controller.position.pixels != 0;
//     if (reachMaxExtent && outOfRange) {
//       await _fetchFirestoreData();
//     }
//   }
// }

final popularOrganizationProvider = StateNotifierProvider<
        PopularOrganizationNotifier, AsyncValue<List<Organization>>>(
    (ref) => PopularOrganizationNotifier(ref: ref));

class PopularOrganizationNotifier
    extends StateNotifier<AsyncValue<List<Organization>>> {
  PopularOrganizationNotifier({required this.ref}) : super(AsyncLoading());

  final Ref ref;
}
