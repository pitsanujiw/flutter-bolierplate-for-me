export 'codeInput.dart';
export './phoneInput.dart';
export './searchInput.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Input extends StatelessWidget {
  final TextInputType keyboardType;
  final String labelText;
  final String hintText;
  final bool loading;
  final String initialValue;
  final bool obscureText;
  final int maxLines;
  final int minLines;
  final Function(String) onSaved;
  final Function(String) onChanged;
  final Function(String) validator;
  final AutovalidateMode autovalidationMode;
  final List<TextInputFormatter> inputFormatters;
  final TextCapitalization textCapitalization;
  final FloatingLabelBehavior floatingLabelBehavior;
  final Widget prefix;
  final Widget prefixIcon;
  final String prefixText;
  final Widget suffix;
  final GestureTapCallback onTap;
  final EdgeInsets padding;
  final int maxLength;
  final String counterText;
  final TextEditingController controller;
  final TextInputAction textInputAction;
  final FocusNode focusNode;
  final Widget suffixIcon;
  final Color fillColor;

  const Input({
    Key key,
    @required this.keyboardType,
    @required this.labelText,
    this.onSaved,
    this.floatingLabelBehavior,
    this.onChanged,
    this.validator,
    this.autovalidationMode = AutovalidateMode.onUserInteraction,
    this.inputFormatters = const [],
    this.padding = const EdgeInsets.symmetric(
      horizontal: 25,
      vertical: 5,
    ),
    this.loading = false,
    this.initialValue,
    this.textCapitalization = TextCapitalization.none,
    this.maxLines = 1,
    this.minLines = 1,
    this.obscureText = false,
    this.hintText,
    this.prefix,
    this.prefixText,
    this.suffix,
    this.prefixIcon,
    this.suffixIcon,
    this.onTap,
    this.maxLength,
    this.counterText,
    this.controller,
    this.textInputAction,
    this.focusNode,
    this.fillColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double borderRadius = 5;

    return Padding(
      padding: this.padding,
      child: TextFormField(
        cursorColor: Colors.blue,
        cursorHeight: 22,
        inputFormatters: this.inputFormatters,
        controller: this.controller,
        maxLength: this.maxLength,
        onTap: this.onTap,
        enabled: !this.loading,
        initialValue: this.initialValue,
        textCapitalization: this.textCapitalization,
        keyboardType: this.keyboardType,
        autofocus: false,
        autovalidateMode: this.autovalidationMode,
        obscureText: this.obscureText,
        minLines: this.minLines,
        maxLines: this.maxLines,
        decoration: InputDecoration(
          counterText: this.counterText,
          errorMaxLines: 2,
          fillColor: this.fillColor ?? Colors.grey[200],
          errorStyle: TextStyle(
            color: Colors.red,
          ),
          prefixIcon: this.prefixIcon != null
              ? Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: this.prefixIcon,
                )
              : null,
          prefix: this.prefix != null
              ? Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: this.prefix,
                )
              : null,
          prefixText: this.prefixText?.isNotEmpty ?? false
              ? "${this.prefixText.trim()} "
              : null,
          suffix: this.suffix,
          prefixStyle: TextStyle(
            color: Colors.grey,
            fontSize: 16,
            height:
                0.95, // to fix bottom padding overflow error on layout builder
          ),
          floatingLabelBehavior: this.floatingLabelBehavior != null
              ? this.floatingLabelBehavior
              : FloatingLabelBehavior.auto,
          labelText: this.labelText,
          labelStyle: TextStyle(
            color: Colors.grey,
            fontSize: 16,
          ),
          hintText: this.hintText,
          filled: true,
          isDense: true,
          suffixIcon: this.suffixIcon,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        onSaved: this.onSaved,
        onChanged: this.onChanged,
        validator: this.validator,
        textInputAction: this.textInputAction,
        focusNode: this.focusNode,
      ),
    );
  }
}
