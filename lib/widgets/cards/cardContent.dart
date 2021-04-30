import 'package:flutter/material.dart';
// import 'package:carinspection/helpers/helpers.dart';

class ContentCard extends StatelessWidget {
  final double? height;
  final EdgeInsets margin;
  final Widget? child;
  const ContentCard({
    Key? key,
    this.height,
    @required this.child,
    this.margin = const EdgeInsets.symmetric(
      horizontal: 22,
      vertical: 10,
    ),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double borderRadius = 5;
    return Container(
      // height: this.height ?? (Device.maxWidth * 0.9),
      height: this.height,
      margin: this.margin,
      child: PhysicalModel(
        color: Colors.white,
        elevation: 12,
        borderRadius: BorderRadius.circular(borderRadius),
        child: this.child,
      ),
    );
  }
}
