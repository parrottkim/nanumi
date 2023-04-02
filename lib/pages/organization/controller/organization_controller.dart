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
  ListNotifier({required this.ref}) : super(AsyncValue.loading()) {
    _fetchFirestoreData();
    controller.addListener(() => _scrollListeners());
  }

  final ScrollController controller = ScrollController();
  final OrganizationRepository _repository = OrganizationRepository();

  final Ref ref;

  bool _isLoading = false;
  int totalCount = 0;

  _fetchFirestoreData() async {
    if (_isLoading) return;
    _isLoading = true;

    final filter =
        ref.watch(filterProvider.notifier).filter[ref.watch(filterProvider)];

    totalCount = await _repository.organizationTotalCount(filter);
    if (totalCount == 0) {
      state = AsyncValue.data([]);
    }
    _repository.listenOrganizationStream(filter).listen((event) {
      state = AsyncValue.data(event);

      print(state.value!.length);
    });

    _isLoading = false;
  }

  _scrollListeners() async {
    final reachMaxExtent =
        controller.offset >= controller.position.maxScrollExtent - 20.0;
    final outOfRange =
        !controller.position.outOfRange && controller.position.pixels != 0;
    if (reachMaxExtent && outOfRange) {
      await _fetchFirestoreData();
    }
  }

  refresh() async {
    state = AsyncLoading();
    await _fetchFirestoreData();
  }

  // increaseCount(Organization organization) {
  //   state = AsyncValue.data([
  //     for (var element in state.value!)
  //       if (element.id == organization.id)
  //         element.copyWith(likes: element.likes + 1),
  //   ]);
  // }

  // decreaseCount(Organization organization) {
  //   state = AsyncValue.data([
  //     for (var element in state.value!)
  //       if (element.id == organization.id)
  //         element.copyWith(likes: element.likes - 1),
  //   ]);
  // }
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
