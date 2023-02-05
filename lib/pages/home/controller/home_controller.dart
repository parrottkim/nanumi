import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nanumi/models/organization.dart';
import 'package:nanumi/repositories/firebase_repository.dart';

final allOrganizationProvider =
    StreamProvider.autoDispose<List<Organization>>((ref) {
  var stream = FirebaseRepository().allOrganizations;
  return stream.map((snapshot) => snapshot.docs
      .map<Organization>((doc) => Organization.fromJson(doc.data()))
      .toList());
});
