import 'package:flutter/material.dart';

enum ShimmerShape {
  square,
  rectangle,
  circle,
}

class ShimmerBox extends StatelessWidget {
  final ShimmerShape shape;
  final double? size;
  final double? width;
  final double? height;

  const ShimmerBox({
    Key? key,
    this.shape = ShimmerShape.rectangle,
    this.size,
    this.width,
    this.height = 15,
  }) : super(key: key);

  const ShimmerBox.title({
    Key? key,
    this.shape = ShimmerShape.rectangle,
    this.width = 200,
    this.height = 30,
  })  : this.size = 1,
        super(key: key);

  const ShimmerBox.square({
    Key? key,
    this.shape = ShimmerShape.square,
    this.size = 7,
  })  : this.width = null,
        this.height = null,
        super(key: key);

  const ShimmerBox.circle({
    Key? key,
    this.shape = ShimmerShape.circle,
    this.size = 7,
  })  : this.width = null,
        this.height = null,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (this.shape) {
      case ShimmerShape.circle:
        return ClipOval(
          child: Container(
            color: Colors.white,
            height: this.size! * 10,
            width: this.size! * 10,
          ),
        );

      case ShimmerShape.square:
        return ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Container(
            color: Colors.white,
            height: this.size! * 10,
            width: this.size! * 10,
          ),
        );

      default:
        return ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Container(
            color: Colors.white,
            height: this.height,
            width: this.width,
          ),
        );
    }
  }
}
