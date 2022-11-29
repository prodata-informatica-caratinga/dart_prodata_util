import 'package:dart_prodata_util/src/config.dart';
import 'package:flutter/material.dart';

Future<bool> showInfoDialog(BuildContext context, {String? title, String? message}) async {
  return await showDialog(context: context, builder: (context) => AlertDialog(
    insetPadding: Config.utilTheme.genericDialogTheme.padding,
    titlePadding: Config.utilTheme.genericDialogTheme.padding,

    title: title != null ? Text(title,
      textAlign: TextAlign.center,
      style: Config.utilTheme.genericDialogTheme.titleStyle,
    ) : null,

    content: message != null ? Text(message,
      textAlign: TextAlign.justify,
      style: Config.utilTheme.genericDialogTheme.messageStyle,
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

Future<bool> showConfirmDialog(BuildContext context, String message) async {
  return await showDialog(context: context, builder: (context) => AlertDialog(
    titlePadding: Config.utilTheme.genericDialogTheme.padding,

    title: Text(
      message,
      textAlign: TextAlign.justify,
      style: Config.utilTheme.genericDialogTheme.messageStyle,
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