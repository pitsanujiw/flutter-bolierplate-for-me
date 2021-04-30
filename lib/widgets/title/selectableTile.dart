import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carinspection/widgets/widgets.dart';
import 'package:carinspection/common/common.dart';

enum SelectableType {
  radio,
  checkbox,
  tick,
  toggle,
}

class SelectableTile extends StatelessWidget {
  final SelectableType type;
  final String? text;
  final bool? isSelected;
  final bool enabled;
  final Function? onChanged;
  final EdgeInsets contentPadding;
  final bool onLeading;

  const SelectableTile.left({
    Key? key,
    this.type = SelectableType.checkbox,
    @required this.text,
    @required this.isSelected,
    this.enabled = true,
    @required this.onChanged,
    this.contentPadding = const EdgeInsets.symmetric(
      horizontal: 15,
      vertical: 10,
    ),
  })  : this.onLeading = true,
        super(key: key);

  const SelectableTile.right({
    Key? key,
    this.type = SelectableType.checkbox,
    @required this.text,
    @required this.isSelected,
    this.enabled = true,
    @required this.onChanged,
    this.contentPadding = const EdgeInsets.symmetric(
      horizontal: 15,
      vertical: 10,
    ),
  })  : this.onLeading = false,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    Color handleActiveColor() {
      if (!this.enabled) {
        return Colors.grey;
      }

      return Colors.black;
    }

    Widget handleType() {
      switch (this.type) {
        case SelectableType.radio:
          return Radio<bool>(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            activeColor: ColorsList.blueActive,
            value: this.isSelected!,
            groupValue: true,
            onChanged: (_) => this.onChanged!(),
          );

        case SelectableType.tick:
          return Icon(Icons.done_rounded);

        case SelectableType.toggle:
          return Transform.scale(
            scale: 0.8,
            child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: CupertinoSwitch(
                activeColor: ColorsList.blueActive,
                value: this.isSelected!,
                onChanged: (_) => this.onChanged!(),
              ),
            ),
          );

        default:
          return Checkbox(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            value: this.isSelected,
            onChanged: (_) => this.onChanged!(),
          );
      }
    }

    return this.onLeading
        ? BaseTile(
            padding: this.contentPadding,
            onTap: this.onChanged,
            leading: SizedBox(
              width: 20,
              height: 20,
              child: handleType(),
            ),
            topLeft: Text(
              this.text.toString(),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(
                fontSize: 16,
                color: handleActiveColor(),
              ),
            ),
          )
        : BaseTile(
            padding: this.contentPadding,
            onTap: this.onChanged,
            topLeft: Text(
              this.text.toString(),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(
                fontSize: 16,
                color: handleActiveColor(),
              ),
            ),
            topRight: SizedBox(
              width: 20,
              height: 20,
              child: handleType(),
            ),
          );
  }
}
