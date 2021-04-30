import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class BlankCard extends StatelessWidget {
  final EdgeInsets margin;
  final EdgeInsets contentPadding;
  final Widget? child;
  final CrossAxisAlignment crossAxisAlignment;
  final double elevation;

  const BlankCard({
    Key? key,
    this.margin = const EdgeInsets.symmetric(
      horizontal: 10,
      vertical: 5,
    ),
    this.contentPadding = const EdgeInsets.all(0),
    required this.child,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.elevation = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: this.margin,
      child: PhysicalModel(
        color: Colors.white,
        shadowColor: Colors.black26,
        borderRadius: BorderRadius.circular(5),
        elevation: this.elevation,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Material(
            color: Colors.white,
            child: Padding(
              padding: this.contentPadding,
              child: this.child ?? const SizedBox(height: 20),
            ),
          ),
        ),
      ),
    );
  }
}
