import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

final areaProvider =
    StateNotifierProvider<AreaNotifier, List<String>>((ref) => AreaNotifier());

class AreaNotifier extends StateNotifier<List<String>> {
  AreaNotifier() : super([]) {
    _fetchFirestoreData();
  }

  _fetchFirestoreData() async {
    var data = await _firestore.collection('organizations').get();
    for (var element in data.docs) {
      if (element['area'] != '') state = [...state, ...element['area']];
    }
    state = state.toSet().toList();
    state.sort((a, b) => a.compareTo(b));
  }
}

final domainProvider = StateNotifierProvider<DomainNotifier, List<String>>(
    (ref) => DomainNotifier());

class DomainNotifier extends StateNotifier<List<String>> {
  DomainNotifier() : super([]) {
    _fetchFirestoreData();
  }

  _fetchFirestoreData() async {
    var data = await _firestore.collection('organizations').get();
    for (var element in data.docs) {
      if (element['domain'] != '') state = [...state, ...element['domain']];
    }
    state = state.toSet().toList();
    state.sort((a, b) => a.compareTo(b));
  }
}
