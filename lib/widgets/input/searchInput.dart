import 'package:flutter/material.dart';
import 'package:flutter_bolierplate_example/common/common.dart';
class SearchField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool autoFocus;

  const SearchField({
    Key key,
    @required this.controller,
    @required this.hintText,
    this.autoFocus = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kToolbarHeight - 15,
      alignment: Alignment(0, 0),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(5),
      ),
      child: TextField(
        cursorColor: ColorsList.blueActive,
        keyboardType: TextInputType.text,
        textCapitalization: TextCapitalization.sentences,
        controller: this.controller,
        autofocus: this.autoFocus,
        decoration: InputDecoration(
          isDense: true,
          border: InputBorder.none,
          hintText: "${this.hintText} ...",
        ),
      ),
    );
  }
}
