import 'package:flutter/material.dart';

class Line extends StatelessWidget {
  final double margin;
  final double indent;
  final double endIndent;
  final double thickness;

  const Line({
    Key key,
    this.margin = 0,
    this.indent = 15,
    this.endIndent = 15,
    this.thickness = 0.5,
  }) : super(key: key);

  const Line.full({
    Key key,
    this.margin = 0,
    this.indent = 0,
    this.endIndent = 0,
    this.thickness = 0.5,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: this.margin,
      thickness: this.thickness,
      color: Colors.grey[300],
      indent: this.indent,
      endIndent: this.endIndent,
    );
  }
}
