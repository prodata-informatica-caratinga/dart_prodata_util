import 'package:dart_prodata_util/src/config.dart';
import 'package:flutter/material.dart';

Card customCard({
  required String title,
  String? description,
  required Widget child,
  EdgeInsets padding = const EdgeInsets.only(left: 8, right: 8, top: 16),
  double elevation = 0.0,
}) {
  assert(Config.navigatorKey.currentContext != null, 'Context não encontrado. Verifique se a navigatorKey está definida no MaterialApp.');
  return Card(
    elevation: elevation,
    margin: const EdgeInsets.only(left: 3, right: 3, top: 3, bottom: 3),
    child: Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Config.utilTheme.customCardTheme.titleStyle),
          if (description != null)
            Text(
              description,
              style: Config.utilTheme.customCardTheme.descriptionStyle,
              textAlign: TextAlign.justify,
            ),
          Divider(color: Theme.of(Config.navigatorKey.currentContext!).colorScheme.primary.withOpacity(.6)),
          Padding(
            padding: const EdgeInsets.only(top: 0, bottom: 8, left: 12, right: 8),
            child: child,
          ),
        ],
      ),
    ),
  );
}