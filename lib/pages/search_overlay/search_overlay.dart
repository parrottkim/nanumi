import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nanumi/pages/search_overlay/controller/search_overlay_controller.dart';
import 'package:nanumi/pages/search_overlay/widgets/result_overlay.dart';
import 'package:nanumi/widgets/default_icon_button.dart';
import 'package:unicons/unicons.dart';

class SearchOverlay extends ConsumerStatefulWidget {
  SearchOverlay({Key? key}) : super(key: key);

  @override
  ConsumerState<SearchOverlay> createState() => _SearchOverlayState();
}

class _SearchOverlayState extends ConsumerState<SearchOverlay>
    with SingleTickerProviderStateMixin {
  late TextEditingController _searchController;

  late AnimationController _controller;
  late Animation _opacityAnimation;

  @override
  void initState() {
    _searchController = TextEditingController();

    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 100));
    _opacityAnimation = Tween(begin: 0.0, end: 1.0).animate(_controller);
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _controller.dispose();
    super.dispose();
  }

  _insertOverlay() {
    showDialog(context: context, builder: (_) => _searchOverlay());
    _searchController.clear();
    _controller.forward();
  }

  _removeOverlay() {
    Navigator.pop(context);
  }

  Widget _searchOverlay() {
    return Consumer(
      builder: (context, ref, child) => AnimatedBuilder(
        animation: _controller,
        builder: (context, child) => Opacity(
          opacity: _opacityAnimation.value,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Material(
                color: Colors.transparent,
                child: Padding(
                  padding: EdgeInsets.only(
                      left: 8.0,
                      right: 8.0,
                      top: MediaQuery.of(context).viewPadding.top + 6.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: ref.watch(searchTextProvider).isEmpty
                          ? BorderRadius.all(Radius.circular(16.0))
                          : BorderRadius.only(
                              topLeft: Radius.circular(16.0),
                              topRight: Radius.circular(16.0),
                            ),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).shadowColor,
                          spreadRadius: 0.0,
                          blurRadius: 2.0,
                          offset: Offset(0, 3),
                        ),
                      ],
                      color: Theme.of(context).cardColor,
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 16.0, right: 8.0),
                      child: Row(
                        children: [
                          Icon(UniconsLine.search),
                          SizedBox(width: 8.0),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 2.0),
                              child: TextField(
                                autofocus: true,
                                controller: _searchController,
                                maxLines: 1,
                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.zero,
                                  border: InputBorder.none,
                                ),
                                onChanged: (value) => ref
                                    .watch(searchTextProvider.notifier)
                                    .value = value,
                              ),
                            ),
                          ),
                          DefaultIconButton(
                            onPressed: () => _removeOverlay(),
                            icon: Icon(UniconsLine.multiply),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              if (ref.watch(searchTextProvider).isNotEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Divider(
                    height: 1.0,
                    color:
                        Theme.of(context).colorScheme.outline.withOpacity(0.3),
                  ),
                ),
              SingleChildScrollView(
                physics: ClampingScrollPhysics(),
                child: ResultOverlay(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultIconButton(
      onPressed: () {
        ref.watch(overlayProvider) ? _removeOverlay() : _insertOverlay();
      },
      icon: Icon(UniconsLine.search),
    );
  }
}
