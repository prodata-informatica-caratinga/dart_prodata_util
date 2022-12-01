import 'package:dart_prodata_util/src/dialogs/rounded-snackbar.dart';
import 'package:flutter/material.dart';

enum TypeValidator { email, time }

class Validator {
  /// Cria uma validação para um [TextFormField] ou um [DropdownButtonFormField].

  final bool required;
  final double maxValue;
  final double minValue;
  final int minLength;
  final int maxLength;
  final TypeValidator? typeValidator;

  Validator({
    this.required = false,
    this.maxValue = -1,
    this.minValue = -1,
    this.minLength = -1,
    this.maxLength = -1,
    this.typeValidator,
  });

  /// Executa a validação de um [TextFormField].
  execute(String? value) {
    if ((value == null || value.isEmpty) && required) {
      return "Campo obrigatório.";
    }
    if (minLength != maxLength) {
      if (value!.isNotEmpty && value.length < minLength) {
        return "Mínimo $minLength caracteres.";
      }
      if (value.isNotEmpty && maxLength > 0 && value.length > maxLength) {
        return "Máximo $maxLength caracteres.";
      }
    } else {
      // não precisa testar o min já que aqui eles são iguais.
      if (value!.length != maxLength && maxLength > 0) {
        return "Deve conter $maxLength caracteres.";
      }
    }

    double? numeric = double.tryParse(value);
    if(numeric != null) {
      if (minValue > -1 && numeric < minValue) {
        return "Valor mínimo de $minValue.";
      }
      if (maxValue > -1 && numeric > maxValue) {
        return "Valor máximo de $maxValue.";
      }
    }

    if(typeValidator != null) {
      switch (typeValidator!) {
         case TypeValidator.time:
          if (value.length > 6) {
            return "Hora inválida.";
          }
          break;
        case TypeValidator.email:
          var exp = RegExp(
              r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
          if (!exp.hasMatch(value)) {
            return "Email inválido.";
          }
          break;
      }
    }

    return null;
  }

  /// Executa uma validação de requerimento para um [DropdownButtonFormField].
  static String? validateDropDown(dynamic value) => value == null ? 'Campo obrigatório.' : null;

  static String? equals({required String? value, required String compare, required String errorLabel}) {
    if(value == null) return 'Campo obrigatório.';
    if(value != compare) return 'As $errorLabel não conferem.';

    return null;
  }

  /// Exibe uma [SnackBar] de erro de validação.
  static void showError(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(roundedSnackBar(
      'Preencha os campos corretamente.',
      backgroundColor: Colors.red,
      seconds: 3,
    ));
  }
}