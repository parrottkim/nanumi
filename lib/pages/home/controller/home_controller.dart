import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nanumi/models/organization.dart';

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

final recentProvider = StreamProvider<List<Organization>>((ref) async* {
  var commentSnapshot = _firestore
      .collection('organizations')
      .orderBy('recentComment.createdAt', descending: true)
      .limit(10)
      .snapshots();

  await for (var element in commentSnapshot) {
    List<Organization> list = [];
    for (var doc in element.docs) {
      list = [...list, Organization.fromFirestore(doc)];
    }
    yield list;
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
