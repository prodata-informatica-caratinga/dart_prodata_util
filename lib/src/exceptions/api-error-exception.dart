import 'package:dart_prodata_util/src/pro-config.dart';
import 'package:dart_prodata_util/src/dialogs/erro-bottomsheet.dart';
import 'package:dart_prodata_util/src/models/app-error.dart';
import 'package:dart_prodata_util/src/dialogs/rounded-snackbar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

/// Exceção lançada quando ocorre um erro em uma requisição de uma API.
///
/// Suporta uma [Response] e uma [customMessage].
class ApiErrorException implements Exception {
  final Response? response;
  final String? customMessage;

  ApiErrorException({this.response, this.customMessage});

  void showDialogError({VoidCallback? onFinish}) {
    var appError = AppError();
    if (response != null && response!.data is Map) {
      appError = AppError.fromJson(response!.data);
    } else if (response != null && response!.statusCode == 500) {
      appError = AppError.withMessage('Houve uma falha interna no servidor. Contacte o suporte.');
    } else {
      appError = AppError.withMessage(customMessage ?? 'Houve uma falha interna no servidor. Contacte o suporte.');
    }
    showErrorBottomSheet(ProConfig.currentContext, appError: appError, onFinish: onFinish);
  }

  void showSnackBar() {
    String message = '';

    if (response != null && response!.data is Map) {
      var appError = AppError.fromJson(response!.data);
      message = appError.message; // depois aqui montar a mensagem completa com os details
    } else if (response != null && response!.statusCode == 500) {
      message = 'Houve uma falha interna no servidor. Contacte o suporte.';
    } else if (customMessage != null && customMessage!.isNotEmpty) {
      message = customMessage!;
    } else {
      message = 'Falha de segmentação.';
    }

    ScaffoldMessenger.of(ProConfig.currentContext).showSnackBar(roundedSnackBar(
      message,
      backgroundColor: Colors.red,
      seconds: 3,
    ));
  }
}