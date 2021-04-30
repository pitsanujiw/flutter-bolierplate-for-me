import 'package:flutter_bolierplate_example/helpers/helpers.dart';
import 'package:flutter/material.dart';

class Frame extends StatelessWidget {
  final List<Widget> children;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisAlignment mainAxisAlignment;

  const Frame({
    Key? key,
    required this.children,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.mainAxisAlignment = MainAxisAlignment.start,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Device.maxHeight,
      width: Device.maxWidth,
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: this.crossAxisAlignment,
            mainAxisAlignment: this.mainAxisAlignment,
            children: [
              ...(this.children),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}
