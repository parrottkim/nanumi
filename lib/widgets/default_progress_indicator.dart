import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class DefaultProgressIndicator extends StatelessWidget {
  const DefaultProgressIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: SpinKitThreeBounce(
        color: Theme.of(context).colorScheme.secondary,
        size: 16.0,
      ),
    );
  }
}
