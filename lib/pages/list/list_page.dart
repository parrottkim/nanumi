import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nanumi/pages/list/controller/list_controller.dart';
import 'package:nanumi/pages/list/widgets/organization_list_item.dart';
import 'package:nanumi/widgets/default_progress_indicator.dart';

class ListPage extends ConsumerStatefulWidget {
  const ListPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ListPageState();
}

class _ListPageState extends ConsumerState<ListPage>
    with AutomaticKeepAliveClientMixin<ListPage> {
  @override
  bool get wantKeepAlive => true;

  static const _indicatorSize = 100.0;
  bool _renderCompleteState = false;

  ScrollDirection prevScrollDirection = ScrollDirection.idle;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(listProvider);
    final allCount = ref.watch(allCountProvider);

    return CustomRefreshIndicator(
      offsetToArmed: _indicatorSize,
      completeStateDuration: const Duration(seconds: 1),
      onRefresh: () async => ref.refresh(listProvider),
      onStateChanged: (change) {
        if (change.didChange(to: IndicatorState.complete)) {
          setState(() {
            _renderCompleteState = true;
          });
        } else if (change.didChange(to: IndicatorState.idle)) {
          setState(() {
            _renderCompleteState = false;
          });
        }
      },
      builder: (context, child, controller) => Stack(
        children: [
          AnimatedBuilder(
            animation: controller,
            builder: (context, _) {
              if (controller.isArmed &&
                  controller.scrollingDirection == ScrollDirection.reverse &&
                  prevScrollDirection == ScrollDirection.forward) {
                controller.stopDrag();
              }

              prevScrollDirection = controller.scrollingDirection;

              final containerHeight = controller.value * _indicatorSize;

              return Container(
                alignment: Alignment.center,
                height: containerHeight,
                child: OverflowBox(
                  maxHeight: 40,
                  minHeight: 40,
                  maxWidth: 40,
                  minWidth: 40,
                  alignment: Alignment.center,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: _renderCompleteState
                          ? Colors.greenAccent
                          : controller.isDragging || controller.isArmed
                              ? Colors.black
                              : Colors.transparent,
                      shape: BoxShape.circle,
                    ),
                    child: _renderCompleteState
                        ? const Icon(
                            Icons.check,
                            color: Colors.white,
                          )
                        : SizedBox(
                            height: 30,
                            width: 30,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation(
                                controller.isDragging || controller.isArmed
                                    ? Colors.white
                                    : Colors.transparent,
                              ),
                              value: controller.isDragging || controller.isArmed
                                  ? controller.value.clamp(0.0, 1.0)
                                  : null,
                            ),
                          ),
                  ),
                ),
              );
            },
          ),
          AnimatedBuilder(
            builder: (context, _) => Transform.translate(
              offset: Offset(0.0, controller.value * _indicatorSize),
              child: child,
            ),
            animation: controller,
          ),
        ],
      ),
      child: NotificationListener<ScrollNotification>(
        child: LayoutBuilder(
          builder: (context, constraints) => ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: ListView.separated(
              padding: EdgeInsets.all(16.0),
              itemCount:
                  state.length < allCount ? state.length + 1 : state.length,
              itemBuilder: (context, index) => index != state.length
                  ? OrganizationListItem(
                      organization: state[index],
                    )
                  : DefaultProgressIndicator(),
              separatorBuilder: (context, index) => SizedBox(height: 16.0),
            ),
          ),
        ),
        onNotification: (notification) {
          if (notification.metrics.extentBefore ==
              notification.metrics.maxScrollExtent) {
            ref.watch(listProvider.notifier).fetchFirestoreData();
          }
          return false;
        },
      ),
    );
  }
}
