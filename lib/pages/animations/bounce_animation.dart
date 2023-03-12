import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final bounceProvider =
    StateNotifierProvider<BounceNotifier, bool>((_) => BounceNotifier(false));

class BounceNotifier extends StateNotifier<bool> {
  BounceNotifier(bool state) : super(state);

  void toggle() {
    state = !state;
  }
}

class BounceAnimation extends HookConsumerWidget {
  BounceAnimation({
    Key? key,
    this.delay = const Duration(milliseconds: 0),
    this.duration = const Duration(milliseconds: 100),
    required this.child,
  }) : super(key: key);

  final Duration delay;
  final Duration duration;
  final Widget child;

  static double beginPoint = 1.0;
  static double endPoint = 1.2;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _controller = useAnimationController(
        duration: duration,
        lowerBound: beginPoint,
        upperBound: endPoint,
        initialValue: beginPoint);

    final _bool = ref.watch(bounceProvider);

    useValueChanged(_bool, (_, __) async {
      _controller.forward();
      await Future.delayed(duration);
      _controller.reverse();
    });

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => Transform.scale(
        scale: _controller.value,
        child: child,
      ),
      child: child,
    );
  }
}
