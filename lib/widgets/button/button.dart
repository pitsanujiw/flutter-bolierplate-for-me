export './underlineTextButton.dart';

import 'package:flutter_bolierplate_example/common/colors.dart';
import 'package:flutter/material.dart';

enum ButtonType {
  primary,
  secondary,
  flat,
}

class Button extends StatelessWidget {
  final String text;
  final Color color;
  final Color textColor;
  final Function onTap;
  final bool enabled;
  final ButtonType type;
  final EdgeInsets margin;
  final double elevation;
  final BorderRadius? borderRadius;

  const Button.primary({
    Key? key,
    required this.text,
    required this.onTap,
    this.enabled = true,
    this.margin = const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
    this.textColor = Colors.white,
    this.color = ColorsList.blueActive,
    this.borderRadius,
  })  : this.type = ButtonType.primary,
        this.elevation = 8,
        super(key: key);

  const Button.secondary({
    Key? key,
    required this.text,
    required this.onTap,
    this.enabled = true,
    this.margin = const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
    this.borderRadius,
    this.textColor = ColorsList.blueActive,
  })  : this.color = Colors.transparent,
        this.type = ButtonType.secondary,
        this.elevation = 0,
        super(key: key);

  const Button.flat({
    Key? key,
    required this.text,
    required this.onTap,
    this.enabled = true,
    this.textColor = ColorsList.blueActive,
    this.borderRadius,
    this.margin = const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
  })  : this.color = Colors.transparent,
        this.type = ButtonType.flat,
        this.elevation = 0,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    Color handleTextColor() {
      switch (this.type) {
        case ButtonType.primary:
          return this.textColor;

        default:
          if (this.enabled) {
            return this.textColor;
          }
          return Colors.grey;
      }
    }

    Color handleColor() {
      switch (this.type) {
        case ButtonType.primary:
          if (this.enabled) {
            return this.color;
          }
          return Colors.grey;

        default:
          return this.color;
      }
    }

    return Container(
      margin: this.margin,
      constraints: BoxConstraints(
        maxHeight: 50,
        minHeight: 50,
        maxWidth: 500,
      ),
      child: MaterialButton(
        elevation: this.elevation,
        disabledElevation: 0,
        highlightElevation: 0,
        color: handleColor(),
        disabledColor: handleColor(),
        shape: RoundedRectangleBorder(
          borderRadius: this.borderRadius ?? BorderRadius.circular(5),
          side: this.type == ButtonType.secondary
              ? BorderSide(
                  width: 2,
                  color: handleTextColor(),
                )
              : BorderSide.none,
        ),
        child: Center(
          heightFactor: 1,
          child: Text(
            this.text.toString().toUpperCase(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: handleTextColor(),
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
              fontSize: 16,
            ),
          ),
        ),
        onPressed: () => this.enabled ? this.onTap() : null,
      ),
    );
  }
}
