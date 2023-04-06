import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nanumi/pages/search_overlay/controller/search_overlay_controller.dart';
import 'package:nanumi/pages/search_overlay/widgets/result_list.dart';
import 'package:unicons/unicons.dart';

class ResultOverlay extends ConsumerStatefulWidget {
  const ResultOverlay({super.key});

  @override
  ConsumerState<ResultOverlay> createState() => _ResultOverlayState();
}

class _ResultOverlayState extends ConsumerState<ResultOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _opacityAnimation;

  final LayerLink _layerLink = LayerLink();

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 100));
    _opacityAnimation = Tween(begin: 0.0, end: 1.0).animate(_controller);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final text = ref.watch(searchTextProvider);

    ref.listen<String>(searchTextProvider, (previous, next) {
      if (next.isNotEmpty) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });

    return CompositedTransformTarget(
      link: _layerLink,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) => Opacity(
          opacity: _opacityAnimation.value,
          child: Material(
            color: Colors.transparent,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Ink(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16.0),
                    bottomRight: Radius.circular(16.0),
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
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 16.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        children: [
                          Icon(
                            UniconsLine.bag,
                            size: 16.0,
                          ),
                          SizedBox(width: 6.0),
                          Text(
                            '이름 조회 결과',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 8.0),
                    if (text.isNotEmpty)
                      ResultList(
                        result: ref.watch(nameProvider(text)),
                      ),
                    SizedBox(height: 16.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        children: [
                          Icon(
                            UniconsLine.globe,
                            size: 16.0,
                          ),
                          SizedBox(width: 6.0),
                          Text(
                            '사업국 조회 결과',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 8.0),
                    if (text.isNotEmpty)
                      ResultList(
                        result: ref.watch(areaProvider(text)),
                      ),
                    SizedBox(
                        height: text.isNotEmpty &&
                                (ref.watch(nameProvider(text)).isNotEmpty ||
                                    ref.watch(areaProvider(text)).isNotEmpty)
                            ? 8.0
                            : 16.0),
                    if (text.isNotEmpty &&
                        (ref.watch(nameProvider(text)).isNotEmpty ||
                            ref.watch(areaProvider(text)).isNotEmpty))
                      InkWell(
                        onTap: () => Navigator.pushNamed(
                          context,
                          '/search',
                          arguments: text,
                        ),
                        child: Ink(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(16.0),
                              bottomRight: Radius.circular(16.0),
                            ),
                            color: Theme.of(context).shadowColor,
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 8.0),
                            child: Row(
                              children: [
                                Icon(
                                  UniconsLine.ellipsis_h,
                                  size: 16.0,
                                ),
                                SizedBox(width: 6.0),
                                Text('더 보기'),
                              ],
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
