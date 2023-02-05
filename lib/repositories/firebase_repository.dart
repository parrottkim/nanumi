import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FirebaseRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late CollectionReference _organizations;

  Stream get allOrganizations =>
      _firestore.collection('organizations').snapshots();
}
