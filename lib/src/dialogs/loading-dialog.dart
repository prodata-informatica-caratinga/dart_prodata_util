// ignore_for_file: use_build_context_synchronously

import 'package:dart_prodata_util/src/pro-config.dart';
import 'package:dart_prodata_util/src/dialogs/erro-bottomsheet.dart';
import 'package:dart_prodata_util/src/exceptions/api-error-exception.dart';
import 'package:dart_prodata_util/src/models/app-error.dart';
import 'package:dart_prodata_util/src/dialogs/rounded-snackbar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Exibe um [Dialog] que impede o usuário de mexer na tela enquanto a [operation] estiver sendo executada.
/// Após a finalização da mesma, se o parâmetro [closeOnFinish] for igual à true, o [context] atual será fechado.
///
/// Os argumentos [context] e [operation] não podem ser nulos.
Future<bool> showSavingDialog(BuildContext context, {required Future<bool> Function() operation, double? size, bool closeOnFinish = true}) async {
  bool result = false;

  FocusScope.of(context).unfocus();
  showDialog(
    barrierDismissible: false,
    context: context,
    barrierColor: Colors.black.withOpacity(.85),
    builder: (_) => WillPopScope( //Previnir que o Dialog feche ao aperter botão de Back
      onWillPop: () => Future(() => false),
      child: SizedBox(height: size, width: size, child: ProConfig.utilTheme.loadingProgressIndicator),
    ),
  );

  try {
    result = await operation();
    Navigator.pop(context); // Fechando showDialog
  } on ApiErrorException catch(e,s) {
    if(kDebugMode) print('- Erro no showSavingDialog: $e\n$s');

    Navigator.pop(context); // Fechando showDialog
    e.showDialogError();
  } catch(e,s) {
    if(kDebugMode) print('- Erro no showSavingDialog: $e\n$s');

    final appError = AppError.withMessage(e.toString().replaceAll('Exception: ', ''));
    Navigator.pop(context); // Fechando showDialog
    showErrorBottomSheet(context, appError: appError);
  }

  if (closeOnFinish && result) {
    ScaffoldMessenger.of(context).showSnackBar(roundedSnackBar(
      'Registro processado com sucesso!',
      backgroundColor: Colors.green,
      seconds: 3,
    ));
    // Fechando tela principal se operação concluída com sucesso
    Navigator.pop(context, true);
  }
  return result;
}

/// Exibe um [Dialog] que impede o usuário de mexer na tela enquanto a [operation] estiver sendo executada.
///
/// Os argumentos [context] e [operation] não podem ser nulos.
Future<void> showLoadingDialog(BuildContext context, {required AsyncCallback operation, double? size}) async {
  FocusScope.of(context).unfocus();
  showDialog(
    barrierDismissible: false,
    context: context,
    barrierColor: Colors.black.withOpacity(.85),
    builder: (_) => WillPopScope( //Previnir que o Dialog feche ao aperter botão de Back
      onWillPop: () => Future(() => false),
      child: SizedBox(height: size, width: size, child: ProConfig.utilTheme.loadingProgressIndicator),
    ),
  );

  try {
    await operation();
    Navigator.pop(context);
  } on ApiErrorException catch(e,s) {
    if(kDebugMode) print('- Erro no showLoadingDialog: $e\n$s');

    Navigator.pop(context); // Fechando showDialog
    e.showDialogError();
  } catch(e,s) {
    if(kDebugMode) print('- Erro no showLoadingDialog: $e\n$s');

    final appError = AppError.withMessage(e.toString().replaceAll('Exception: ', ''));
    Navigator.pop(context); // Fechando showDialog
    showErrorBottomSheet(context, appError: appError);
  }
}