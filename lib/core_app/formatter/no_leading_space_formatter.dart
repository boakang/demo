import 'package:flutter/services.dart';

class NoLeadingSpaceFormatter extends TextInputFormatter {
  const NoLeadingSpaceFormatter();

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    if (!newValue.text.startsWith(' ')) {
      return newValue;
    }

    final trimmedText = newValue.text.trimLeft();
    final selectionOffset = trimmedText.length;

    return TextEditingValue(
      text: trimmedText,
      selection: TextSelection.collapsed(offset: selectionOffset),
    );
  }
}

