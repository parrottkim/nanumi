import 'package:flutter/material.dart';

class _PreferredAppBarSize extends Size {
  _PreferredAppBarSize(this.toolbarHeight, this.bottomHeight)
      : super.fromHeight(
            (toolbarHeight ?? kToolbarHeight) + (bottomHeight ?? 0));

  final double? toolbarHeight;
  final double? bottomHeight;
}

class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  DefaultAppBar({
    Key? key,
    this.elevation = 2.0,
    this.centerTitle = false,
    this.title,
    this.leading,
    this.action,
    this.bottom,
    this.backgroundColor,
    this.toolbarHeight = 56.0,
  }) : preferredSize =
            _PreferredAppBarSize(toolbarHeight, bottom?.preferredSize.height);

  final double? elevation;
  final bool? centerTitle;
  final Widget? title;
  final Widget? leading;
  final List<Widget>? action;
  final PreferredSizeWidget? bottom;
  final Color? backgroundColor;
  final double toolbarHeight;

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: elevation,
      backgroundColor:
          backgroundColor ?? Theme.of(context).appBarTheme.backgroundColor,
      centerTitle: centerTitle,
      automaticallyImplyLeading: false,
      leading: leading,
      title: title,
      actions: action,
      bottom: bottom,
    );
  }
}
