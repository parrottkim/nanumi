import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class _PreferredAppBarSize extends Size {
  _PreferredAppBarSize(this.toolbarHeight, this.bottomHeight)
      : super.fromHeight(
            (toolbarHeight ?? kToolbarHeight) + (bottomHeight ?? 0));

  final double? toolbarHeight;
  final double? bottomHeight;
}

class DashboardAppBar extends StatelessWidget implements PreferredSizeWidget {
  DashboardAppBar({
    Key? key,
    this.elevation = 2.0,
    this.centerTitle = false,
    this.title,
    this.leading,
    this.action,
    this.bottom,
    this.backgroundColor = Colors.white,
    this.brightness = Brightness.light,
    this.toolbarHeight = 56.0,
  }) : preferredSize =
            _PreferredAppBarSize(toolbarHeight, bottom?.preferredSize.height);

  final double? elevation;
  final bool? centerTitle;
  final Widget? title;
  final Widget? leading;
  final List<Widget>? action;
  final PreferredSizeWidget? bottom;
  final Color backgroundColor;
  final Brightness brightness;
  final double toolbarHeight;

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: elevation,
      backgroundColor: backgroundColor,
      centerTitle: centerTitle,
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (leading != null) leading!,
          if (title != null) title!,
          Spacer(),
          if (action != null)
            Row(
              children: [
                ...action!,
              ],
            ),
        ],
      ),
      bottom: bottom,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarBrightness: brightness,
      ),
    );
  }
}
