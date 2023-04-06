import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nanumi/models/organization.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final StreamController<List<Organization>> _streamController =
    StreamController<List<Organization>>.broadcast();

class NameSearchRepository {
  List<List<Organization>> _organizations = [];
  DocumentSnapshot? _lastDocument;

  Stream<List<Organization>> listenOrganizationStream(String text) {
    fetchOrganizationList(text);
    return _streamController.stream;
  }

  void fetchOrganizationList(String text, [int limit = 10]) {
    var query = _firestore
        .collection('organizations')
        .where('name', isGreaterThanOrEqualTo: text)
        .where('name', isLessThan: text + '\uf8ff')
        .orderBy('name')
        .orderBy('likes', descending: true)
        .limit(limit);
    List<Organization> results = [];

    if (_lastDocument != null) {
      query = query.startAfterDocument(_lastDocument!);
    }

    var currentRequestIndex = _organizations.length;

    query.snapshots().listen((event) {
      if (event.docs.isNotEmpty) {
        var organizations = event.docs
            .map((element) => Organization.fromFirestore(element))
            .toList();

        var pageExists = currentRequestIndex < _organizations.length;

        if (pageExists) {
          _organizations[currentRequestIndex] = organizations;
        } else {
          _organizations.add(organizations);
        }

        results = _organizations.fold<List<Organization>>(
            [], (initialValue, pageItems) => initialValue..addAll(pageItems));

        _streamController.add(results);
      }

      if (results.isNotEmpty &&
          currentRequestIndex == _organizations.length - 1) {
        _lastDocument = event.docs.last;
      }
      return;
    });
  }

  Future<int> organizationTotalCount(String text) async {
    AggregateQuerySnapshot query = await _firestore
        .collection('organizations')
        .where('name', isGreaterThanOrEqualTo: text)
        .where('name', isLessThan: text + '\uf8ff')
        .orderBy('name')
        .orderBy('likes', descending: true)
        .count()
        .get();
    return query.count;
  }
}
