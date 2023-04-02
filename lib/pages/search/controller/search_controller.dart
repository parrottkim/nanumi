import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nanumi/models/organization.dart';
import 'package:nanumi/pages/search/widgets/area_list.dart';
import 'package:nanumi/pages/search/widgets/domain_list.dart';
import 'package:nanumi/repositories/area_search_repository.dart';
import 'package:nanumi/repositories/domain_search_repository.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;

final tabBarProvider =
    StateNotifierProvider<TabBarNotifier, int>((ref) => TabBarNotifier());

class TabBarNotifier extends StateNotifier<int> {
  TabBarNotifier() : super(0);

  set value(int index) => state = index;
}

final areaProvider = StateNotifierProvider.family<
    AreaNotifier,
    AsyncValue<List<Organization>>,
    String>((ref, text) => AreaNotifier(ref: ref, text: text));

class AreaNotifier extends StateNotifier<AsyncValue<List<Organization>>> {
  AreaNotifier({required this.ref, required this.text})
      : super(AsyncValue.loading()) {
    _fetchFirestoreData();
    controller.addListener(() => _scrollListeners());
  }

  final ScrollController controller = ScrollController();
  final AreaSearchRepository _repository = AreaSearchRepository();

  final Ref ref;
  final String text;

  bool _isLoading = false;
  int totalCount = 0;

  _fetchFirestoreData() async {
    if (_isLoading) return;
    _isLoading = true;

    totalCount = await _repository.organizationTotalCount(text);
    if (totalCount == 0) {
      state = AsyncValue.data([]);
    }
    _repository.listenOrganizationStream(text).listen((event) {
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
}

final domainProvider = StateNotifierProvider.family<
    DomainNotifier,
    AsyncValue<List<Organization>>,
    String>((ref, text) => DomainNotifier(ref: ref, text: text));

class DomainNotifier extends StateNotifier<AsyncValue<List<Organization>>> {
  DomainNotifier({required this.ref, required this.text})
      : super(AsyncValue.loading()) {
    _fetchFirestoreData();
    controller.addListener(() => _scrollListeners());
  }

  final ScrollController controller = ScrollController();
  final DomainSearchRepository _repository = DomainSearchRepository();

  final Ref ref;
  final String text;

  bool _isLoading = false;
  int totalCount = 0;

  _fetchFirestoreData() async {
    if (_isLoading) return;
    _isLoading = true;

    totalCount = await _repository.organizationTotalCount(text);
    if (totalCount == 0) {
      state = AsyncValue.data([]);
    }
    _repository.listenOrganizationStream(text).listen((event) {
      state = AsyncValue.data(event);
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
}
