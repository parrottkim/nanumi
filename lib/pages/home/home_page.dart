import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nanumi/pages/home/controller/home_controller.dart';
import 'package:nanumi/repositories/firebase_repository.dart';

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stream = ref.watch(allOrganizationProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('단체 보기'),
      ),
      body: Center(
        child: stream.when(
            data: (data) => ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) =>
                      Text('${data[index].toJson()}'),
                ),
            error: (error, stackTrace) {
              print(error);
              return Icon(Icons.error);
            },
            loading: () => CircularProgressIndicator()),
      ),
    );
  }
}
