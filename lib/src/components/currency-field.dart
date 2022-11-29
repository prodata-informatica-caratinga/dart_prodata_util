import 'package:dart_prodata_util/src/helpers/text-input-formatters.dart';
import 'package:dart_prodata_util/src/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CurrencyField extends StatelessWidget {
  final String label;
  final double? fontSize;
  final String? initialValue;
  final Function? onSaved;
  final Function? onChanged;
  final TextEditingController? controller;
  final EdgeInsets? padding;
  final bool readOnly;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;

  CurrencyField({
    this.label = '',
    this.fontSize,
    this.initialValue,
    this.onSaved,
    this.onChanged,
    this.padding,
    this.controller,
    this.readOnly = false,
    this.textInputAction,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.all(0),
      child: TextFormField(
        initialValue: initialValue,
        controller: controller,
        style: TextStyle(fontSize: fontSize ?? Config.choseSize(16, 20)),
        keyboardType: TextInputType.number,
        textInputAction: textInputAction,
        textAlign: TextAlign.right,
        readOnly: readOnly,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          CurrencyInputFormatter(maxDigits: 8),
        ],
        validator: validator,

        onSaved: onSaved != null
            ? (value) {
          if (value != null) {
            String _onlyDigits = value.replaceAll(RegExp('[^0-9]'), "");
            double _doubleValue = double.parse(_onlyDigits) / 100;
            onSaved!(_doubleValue);
          }
        } : null,

        onChanged: onChanged != null
            ? (value) {
          String _onlyDigits = value.replaceAll(RegExp('[^0-9]'), "");
          double _doubleValue = double.parse(_onlyDigits) / 100;
          onChanged!(_doubleValue);
        }
            : null,
      ),
    );
  }
}