import 'dart:io';

import 'package:flutter_bolierplate_example/common/common.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bolierplate_example/widgets/widgets.dart';

class SmartFrame extends StatelessWidget {
  final GlobalKey<RefreshIndicatorState> refreshKey;
  final Function onRefresh;
  final List<Widget> children;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisAlignment mainAxisAlignment;
  final bool isLoading;
  final Widget? shimmerWidget;

  const SmartFrame({
    Key? key,
    required this.refreshKey,
    required this.onRefresh,
    required this.children,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    required this.isLoading,
    this.shimmerWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CustomScrollView(
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            slivers: [
              CupertinoSliverRefreshControl(
                key: this.refreshKey,
                refreshTriggerPullDistance: 100.0,
                refreshIndicatorExtent: 60.0,
                onRefresh: () => this.onRefresh(),
              ),
              SliverList(
                delegate: SliverChildListDelegate.fixed(this.isLoading
                    ? [this.shimmerWidget ?? const SizedBox()]
                    : this.children),
              )
            ],
          )
        : RefreshIndicator(
            key: this.refreshKey,
            color: ColorsList.blueActive,
            onRefresh: () => this.onRefresh(),
            child: Frame(
              crossAxisAlignment: this.crossAxisAlignment,
              mainAxisAlignment: this.mainAxisAlignment,
              children: this.isLoading
                  ? [this.shimmerWidget ?? const SizedBox()]
                  : this.children,
            ),
          );
  }
}
