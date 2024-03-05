import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nanumi/models/comment.dart';
import 'package:nanumi/models/organization.dart';
import 'package:nanumi/models/recent.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

final popularProvider = StreamProvider<List<Organization>>((ref) async* {
  var snapshot = _firestore
      .collection('organizations')
      .where('likes', isGreaterThanOrEqualTo: 1)
      .orderBy('likes', descending: true)
      .limit(5)
      .snapshots();

  await for (var element in snapshot) {
    List<Organization> organizations = [];
    for (var doc in element.docs) {
      organizations = [...organizations, Organization.fromFirestore(doc)];
    }
    yield organizations;
  }
});

final recentProvider = StreamProvider<List<Recent>>((ref) async* {
  var commentSnapshot = _firestore
      .collection('comments')
      .where('isReported', isEqualTo: false)
      .limit(10)
      .snapshots();

  await for (var comment in commentSnapshot) {
    List<Recent> list = [];
    for (var doc in comment.docs.reversed) {
      var organizationSnapshot = await _firestore
          .collection('organizations')
          .doc(doc.data()['organizationId'])
          .get();

      list = [
        ...list,
        Recent(
            comment: Comment.fromFirestore(doc),
            organization: Organization.fromJson(organizationSnapshot.data()!))
      ];
      list.sort((a, b) => b.comment.createdAt.compareTo(a.comment.createdAt));
      yield list;
    }
  }
});

final bannerProvider = StreamProvider<List<Map>>((ref) async* {
  var commentSnapshot =
      _firestore.collection('banner').orderBy('index').limit(10).snapshots();

  await for (var element in commentSnapshot) {
    List<Map> list = [];
    for (var doc in element.docs) {
      list = [...list, doc.data()];
    }
    yield list;
  }
});

final bannerIndexProvider = StateNotifierProvider<BannerIndexNotifier, int>(
    (ref) => BannerIndexNotifier());

class BannerIndexNotifier extends StateNotifier<int> {
  BannerIndexNotifier() : super(0);

  set value(int index) => state = index;
}
