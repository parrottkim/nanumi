import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nanumi/pages/animations/search_animation.dart';
import 'package:nanumi/widgets/default_icon_button.dart';
import 'package:nanumi/widgets/overlay_builder.dart';
import 'package:unicons/unicons.dart';

class SearchOverlay extends ConsumerWidget {
  const SearchOverlay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return OverlayBuilder(
      child: Material(
        color: Colors.transparent,
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            color: Colors.white,
            child: TextField(),
          ),
        ),
      ),
    );
  }
}
