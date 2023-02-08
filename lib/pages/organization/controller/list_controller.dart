import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nanumi/models/organization.dart';
import 'package:unicons/unicons.dart';

final allCountProvider =
    StateNotifierProvider<AllCountNotifier, int>((ref) => AllCountNotifier());

class AllCountNotifier extends StateNotifier<int> {
  AllCountNotifier() : super(0) {
    _fetchFirestoreCount();
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  _fetchFirestoreCount() async {
    AggregateQuerySnapshot query =
        await _firestore.collection('organizations').count().get();
    state = query.count;
  }
}

final listProvider = StateNotifierProvider<ListNotifier, List<Organization>>(
    (ref) => ListNotifier(ref: ref));

class ListNotifier extends StateNotifier<List<Organization>> {
  ListNotifier({required this.ref}) : super([]) {
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

    print(filter[index]);

    Query<Map<String, dynamic>> query = _firestore
        .collection('organizations')
        .orderBy(filter[index]['flag'],
            descending: filter[index]['descending']);

    if (state.isEmpty) {
      documents = await query.limit(10).get();
    } else {
      documents =
          await query.startAfterDocument(_lastDocuments).limit(10).get();
    }
    _lastDocuments = documents.docs.last;
    _isLoading = false;

    if (mounted) {
      return state = [
        ...state,
        ...documents.docs.map<Organization>(
            (element) => Organization.fromJson(element.data())),
      ];
    }
  }

  refresh() async {
    state.clear();
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
