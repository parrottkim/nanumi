import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nanumi/models/organization.dart';

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

  bool _isLoading = false;
  var documents;
  var _lastDocuments;

  Future<void> fetchFirestoreData() async {
    print('load');
    if (_isLoading) return;
    _isLoading = true;

    ref.watch(allCountProvider);

    if (state.isEmpty) {
      documents = await _firestore.collection('organizations').limit(10).get();
    } else {
      documents = await _firestore
          .collection('organizations')
          .startAfterDocument(_lastDocuments)
          .limit(10)
          .get();
    }
    state = [
      ...state,
      ...documents.docs.map<Organization>(
          (element) => Organization.fromJson(element.data())),
    ];
    _lastDocuments = documents.docs.last;
    _isLoading = false;
  }
}
