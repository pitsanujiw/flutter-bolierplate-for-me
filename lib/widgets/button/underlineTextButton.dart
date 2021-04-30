import 'package:flutter_bolierplate_example/common/common.dart';
import 'package:flutter/material.dart';

class UnderlineTextButton extends StatelessWidget {
  final String text;
  final Function onTap;

  const UnderlineTextButton({
    Key? key,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => this.onTap(),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Text(
          this.text.toString().toUpperCase(),
          textAlign: TextAlign.right,
          style: TextStyle(
            fontSize: 16,
            color: ColorsList.blueActive,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    );
  }
}
