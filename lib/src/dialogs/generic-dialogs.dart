import 'package:dart_prodata_util/src/pro-config.dart';
import 'package:flutter/material.dart';

/// Exibe um [Dialog] que suporta um título e uma mensagem, com um [TextButton] de "Ok" para fechar.
Future<bool> showInfoDialog(BuildContext context, {String? title, String? message}) async {
  return await showDialog(context: context, builder: (context) => AlertDialog(
    insetPadding: ProConfig.utilTheme.genericDialogTheme.padding,
    titlePadding: ProConfig.utilTheme.genericDialogTheme.padding,

    title: title != null ? Text(title,
      textAlign: TextAlign.center,
      style: ProConfig.utilTheme.genericDialogTheme.titleStyle,
    ) : null,

    content: message != null ? Text(message,
      textAlign: TextAlign.justify,
      style: ProConfig.utilTheme.genericDialogTheme.messageStyle,
    ) : null,

    actions: [
      TextButton(
        onPressed: () {
          Navigator.pop(context, true);
        },
        child: const Text('Ok'),
      ),
    ],
  ));
}

/// Exibe um [Dialog] que suporta uma mensagem de confirmação, com dois [TextButton] de "Sim" e "Não" para confirmação de decisão.
Future<bool> showConfirmDialog(BuildContext context, String message) async {
  return await showDialog(context: context, builder: (context) => AlertDialog(
    titlePadding: ProConfig.utilTheme.genericDialogTheme.padding,

    title: Text(
      message,
      textAlign: TextAlign.justify,
      style: ProConfig.utilTheme.genericDialogTheme.messageStyle,
    ),

    actions: [
      TextButton(
        onPressed: () {
          Navigator.pop(context, false);
        },
        child: const Text('Não', style: TextStyle(color: Colors.red),),
      ),
      TextButton(
        onPressed: () {
          Navigator.pop(context, true);
        },
        child: const Text('Sim', style: TextStyle(color: Colors.green),),
      ),
    ],
  ));
}