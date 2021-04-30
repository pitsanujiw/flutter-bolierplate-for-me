import 'package:flutter_bolierplate_example/common/common.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:flutter_bolierplate_example/utils/utils.dart';

class CodeField extends StatelessWidget {
  final Function(String)? onSaved;
  final Function(String)? onChanged;

  const CodeField({
    Key? key,
    this.onSaved,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: PinCodeTextField(
        backgroundColor: Colors.transparent,
        validator: (String? value) => Validator.verificationCode(value!),
        onSaved: (String? value) => this.onSaved!(value!),
        onChanged: (String? value) => this.onChanged!(value!),
        keyboardType: TextInputType.numberWithOptions(
          signed: false,
          decimal: false,
        ),
        animationType: AnimationType.scale,
        appContext: context,
        length: 6,
        textStyle: TextStyle(
          fontSize: 25,
        ),
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(5),
          fieldHeight: 50,
          fieldWidth: 40,
          inactiveColor: Colors.grey,
          selectedColor: ColorsList.blueActive,
          activeColor: Colors.grey,
          borderWidth: 1,
        ),
      ),
    );
  }
}
