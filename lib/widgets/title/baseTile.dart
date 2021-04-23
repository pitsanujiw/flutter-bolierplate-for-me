import 'package:flutter/material.dart';

class BaseTile extends StatelessWidget {
  final EdgeInsets padding;
  final BoxConstraints constraints;
  final Widget leading;
  final Widget topLeft;
  final Widget middleLeft;
  final Widget middleRight;
  final Widget topRight;
  final Widget bottomLeft;
  final Widget bottomRight;
  final Function onTap;

  const BaseTile({
    Key key,
    this.padding = const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
    this.constraints = const BoxConstraints(
      minHeight: 55,
    ),
    this.leading,
    this.topLeft,
    this.topRight,
    this.middleLeft,
    this.middleRight,
    this.bottomLeft,
    this.bottomRight,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: this.onTap,
      child: Container(
        padding: this.padding,
        constraints: this.constraints,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            this.leading ?? Container(),
            if (this.leading != null) SizedBox(width: this.padding.left),
            if (this.topLeft != null ||
                this.middleLeft != null ||
                this.bottomLeft != null)
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (this.topLeft != null) this.topLeft,
                    if (this.middleLeft != null) const SizedBox(height: 5),
                    if (this.middleLeft != null) this.middleLeft,
                    if (this.bottomLeft != null) const SizedBox(height: 5),
                    if (this.bottomLeft != null) this.bottomLeft,
                  ],
                ),
              ),
            if (this.topRight != null ||
                this.middleRight != null ||
                this.bottomRight != null)
              SizedBox(width: this.padding.right),
            if (this.topRight != null ||
                this.middleRight != null ||
                this.bottomRight != null)
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  this.topRight ?? Container(),
                  if (this.middleRight != null) const SizedBox(height: 5),
                  this.middleRight ?? Container(),
                  if (this.bottomRight != null) const SizedBox(height: 5),
                  this.bottomRight ?? Container(),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
