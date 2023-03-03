import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nanumi/models/organization.dart';
import 'package:nanumi/repositories/organization_repository.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

final listProvider =
    StateNotifierProvider<ListNotifier, AsyncValue<List<Organization>>>(
        (ref) => ListNotifier(ref: ref));

class ListNotifier extends StateNotifier<AsyncValue<List<Organization>>> {
  ListNotifier({required this.ref}) : super(AsyncLoading()) {
    _fetchFirestoreData();
    controller.addListener(() => _scrollListeners());
  }

  final ScrollController controller = ScrollController();
  final OrganizationRepository _repository = OrganizationRepository();

  final Ref ref;

  bool _isLoading = false;
  int totalCount = 0;

  List<Organization> updatedList = [];

  _fetchFirestoreData() async {
    if (_isLoading) return;
    _isLoading = true;

    final filter =
        ref.watch(filterProvider.notifier).filter[ref.watch(filterProvider)];

    totalCount = await _repository.organizationTotalCount(filter);
    if (totalCount == 0) {
      state = AsyncValue.data([]);
    }

    var result = [];

    _repository.listenOrganizationStream(filter).listen((event) {
      result = event;
    });
    await Future.delayed(Duration(milliseconds: 400));

    state = AsyncValue.data([
      if (state.value != null) ...state.value!,
      ...result,
    ]);

    _isLoading = false;
  }

  _scrollListeners() async {
    final reachMaxExtent =
        controller.offset >= controller.position.maxScrollExtent - 100.0 &&
            controller.offset < controller.position.maxScrollExtent;
    if (reachMaxExtent) {
      await _fetchFirestoreData();
    }
  }

  void requestMoreData() async => await _fetchFirestoreData();

  refresh() async {
    state = AsyncLoading();
    await _fetchFirestoreData();
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
