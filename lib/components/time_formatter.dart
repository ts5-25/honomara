import 'package:flutter/services.dart';

class TimeInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final text = newValue.text;
    if (text.isEmpty) {
      return newValue;
    }

    final regex = RegExp(r'^\d{0,2}(:\d{0,2})?(:\d{0,2})?$');
    if (!regex.hasMatch(text)) {
      return oldValue;
    }

    return newValue;
  }
}