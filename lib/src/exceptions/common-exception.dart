import 'package:dart_prodata_util/src/dialogs/generic-dialogs.dart';
import 'package:dart_prodata_util/src/dialogs/rounded-snackbar.dart';
import 'package:flutter/material.dart';

enum MessageType { snackBar, dialog }

class CommonException implements Exception {
  final String? title;
  final String message;
  final MessageType messageType;

  CommonException({required this.message, this.title, this.messageType = MessageType.snackBar});

  void show(BuildContext context) {
    if(messageType == MessageType.snackBar) {
      ScaffoldMessenger.of(context).showSnackBar(roundedSnackBar(
        message,
        backgroundColor: Colors.red,
        seconds: 3,
      ));
    } else { // MessageType.dialog
      showInfoDialog(context, title: title ?? 'Atenção!', message: message);
    }
  }
}