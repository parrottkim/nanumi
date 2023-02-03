import 'dart:convert';
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final listProvider =
    StateNotifierProvider<ListNotifier, List<dynamic>>((ref) => ListNotifier());

class ListNotifier extends StateNotifier<List<dynamic>> {
  ListNotifier() : super([]) {
    _fetchList();
  }

  _fetchList() async {
    final file = File('assets/nanumi.csv').openRead();
    state = await file
        .transform(utf8.decoder)
        .transform(new CsvToListConverter())
        .toList();
  }
}
