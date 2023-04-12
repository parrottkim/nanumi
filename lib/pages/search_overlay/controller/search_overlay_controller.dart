import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nanumi/models/organization.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;

final overlayProvider =
    StateNotifierProvider.autoDispose<OverlayNotifier, bool>(
        (ref) => OverlayNotifier());

class OverlayNotifier extends StateNotifier<bool> {
  OverlayNotifier() : super(false);

  set value(bool flag) => state = flag;
}

final searchTextProvider =
    StateNotifierProvider.autoDispose<SearchTextNotifier, String>(
        (ref) => SearchTextNotifier());

class SearchTextNotifier extends StateNotifier<String> {
  SearchTextNotifier() : super('');

  set value(String text) => state = text;
}

final nameProvider =
    StateNotifierProvider.family<NameNotifier, List<Organization>, String>(
        (ref, text) => NameNotifier(ref: ref, text: text));

class NameNotifier extends StateNotifier<List<Organization>> {
  NameNotifier({required this.ref, required this.text}) : super([]) {
    _fetchFirestoreData();
  }

  final Ref ref;
  final String text;

  _fetchFirestoreData() async {
    var snapshot = await _firestore
        .collection('organizations')
        .where('name', isGreaterThanOrEqualTo: text)
        .where('name', isLessThan: text + '\uf8ff')
        .orderBy('name')
        .orderBy('likes', descending: true)
        .limit(3)
        .get();
    state = [
      ...snapshot.docs.map((element) => Organization.fromFirestore(element))
    ];
  }
}

final areaProvider =
    StateNotifierProvider.family<AreaNotifier, List<Organization>, String>(
        (ref, text) => AreaNotifier(ref: ref, text: text));

class AreaNotifier extends StateNotifier<List<Organization>> {
  AreaNotifier({required this.ref, required this.text}) : super([]) {
    _fetchFirestoreData();
  }

  final Ref ref;
  final String text;

  _fetchFirestoreData() async {
    var snapshot = await _firestore
        .collection('organizations')
        .where('area', arrayContains: text)
        .orderBy('likes', descending: true)
        .limit(3)
        .get();
    state = [
      ...snapshot.docs.map((element) => Organization.fromFirestore(element))
    ];
  }
}
