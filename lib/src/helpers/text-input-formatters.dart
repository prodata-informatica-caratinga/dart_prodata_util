import 'package:flutter/services.dart';
import 'package:intl/intl.dart' show NumberFormat;

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(oldValue, newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}

class LowerCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(oldValue, newValue) {
    return TextEditingValue(
      text: newValue.text.toLowerCase(),
      selection: newValue.selection,
    );
  }
}

class CharNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(oldValue, newValue) {
    String value = newValue.text.replaceAll(RegExp('[^0-9a-zA-Z]+'), '');
    return TextEditingValue(
      text: value,
      selection: TextSelection.collapsed(offset: value.length),
    );
  }
}

class CurrencyInputFormatter extends TextInputFormatter {
  final int? maxDigits;

  CurrencyInputFormatter({this.maxDigits});

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    if (maxDigits != null) {
      if(newValue.selection.baseOffset > maxDigits!) {
        return oldValue;
      }
    }

    double value = double.parse(newValue.text);
    final formatter = NumberFormat('#,##0.00', 'pt_BR');
    String newText = 'R\$ ${formatter.format(value / 100)}';

    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}