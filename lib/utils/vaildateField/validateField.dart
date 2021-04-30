import 'package:flutter_bolierplate_example/global/global.dart';

class Validator {
  static String? email(String value) {
    if (value.isEmpty) {
      return t("validator.email.empty");
    }

    String pattern =
        "[a-zA-Z0-9\+\.\_\%\-\+]{1,256}\\@[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}(\\.[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25})+";

    RegExp regExp = RegExp(pattern);

    if (!regExp.hasMatch(value)) {
      return t("validator.email.invalid");
    }

    return null;
  }

  static String? phone(String value) {
    if (value.isEmpty) {
      return 'กรุณาใส่เบอร์โทรศัพท์';
    }

    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';

    RegExp regExp = RegExp(pattern);

    if (!regExp.hasMatch(value)) {
      return 'เบอร์โทรศัพท์ไม่ถูกต้อง';
    }

    return null;
  }

  static String? verificationCode(String value) {
    if (value.isEmpty) {
      return 'กรุณาใส่เลขยืนยันตัวตน';
    }

    return null;
  }

  static String? password(String value) {
    if (value.isEmpty) {
      return 'กรุณากรอกรหัสผ่าน';
    }

    if (value.length < 8) {
      return 'รหัสผ่านต้องมากกว่า 8 ตัวอักษร';
    }

    return null;
  }

  static String? newPassword(String value) {
    if (value.isEmpty) {
      return 'กรุณากรอกรหัสผ่าน';
    }

    if (value.length < 8) {
      return 'รหัสผ่านต้องมากกว่า 8 ตัวอักษร';
    }

    return null;
  }
}
