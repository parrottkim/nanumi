import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nanumi/models/organization.dart';
import 'package:unicons/unicons.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

final organizationTotalCountProvider =
    StateNotifierProvider<OrganizationTotalCountNotifier, int>(
        (ref) => OrganizationTotalCountNotifier());

class OrganizationTotalCountNotifier extends StateNotifier<int> {
  OrganizationTotalCountNotifier() : super(0) {
    _fetchFirestoreCount();
  }

  _fetchFirestoreCount() async {
    AggregateQuerySnapshot query =
        await _firestore.collection('organizations').count().get();
    state = query.count;
  }
}

final likeTotalCountProvider =
    StateNotifierProvider.family<LikeTotalCountNotifier, int, String>(
        (ref, id) => LikeTotalCountNotifier(ref: ref, id: id));

class LikeTotalCountNotifier extends StateNotifier<int> {
  LikeTotalCountNotifier({required this.ref, required this.id}) : super(0) {
    _fetchFirestoreCount();
  }

  final Ref ref;
  final String id;

  _fetchFirestoreCount() async {
    AggregateQuerySnapshot query = await _firestore
        .collection('organizations')
        .doc(id)
        .collection('likes')
        .count()
        .get();
    state = query.count;
  }
}

final listProvider =
    StateNotifierProvider<ListNotifier, AsyncValue<List<Organization>>>(
        (ref) => ListNotifier(ref: ref));

class ListNotifier extends StateNotifier<AsyncValue<List<Organization>>> {
  ListNotifier({required this.ref}) : super(AsyncLoading()) {
    fetchFirestoreData();
  }

  final Ref ref;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late QuerySnapshot<Map<String, dynamic>> documents;
  late QueryDocumentSnapshot<Map<String, dynamic>> _lastDocuments;

  bool _isLoading = false;

  fetchFirestoreData() async {
    if (_isLoading) return;
    _isLoading = true;

    final filter = ref.watch(filterProvider.notifier).filter;
    final index = ref.watch(filterProvider);

    final query = _firestore.collection('organizations').orderBy(
        filter[index]['flag'],
        descending: filter[index]['descending']);

    if (state.value == null) {
      documents = await query.limit(10).get();
    } else {
      documents =
          await query.startAfterDocument(_lastDocuments).limit(10).get();
    }
    _lastDocuments = documents.docs.last;
    _isLoading = false;

    if (mounted) {
      return state = AsyncValue.data([
        if (state.value != null) ...state.value!,
        ...documents.docs.map<Organization>(
            (element) => Organization.fromFirestore(element)),
      ]);
    }
  }

  refresh() async {
    state = AsyncLoading();
    await fetchFirestoreData();
  }
}

final filterProvider =
    StateNotifierProvider<FilterNotifier, int>((ref) => FilterNotifier());

class FilterNotifier extends StateNotifier<int> {
  FilterNotifier() : super(0);

  final List<Map> _filter = [
    {
      'text': '가나다순',
      'flag': 'name',
      'descending': false,
    },
    {
      'text': '좋아요순',
      'flag': 'likes',
      'descending': true,
    },
  ];
  List<Map> get filter => _filter;

  set value(int index) => state = index;
}
