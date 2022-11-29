import 'package:dart_prodata_util/src/config.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final String title;
  final String? description;
  final Widget child;
  final EdgeInsets padding;
  final double elevation;

  CustomCard({
    required this.title,
    this.description,
    required this.child,
    this.padding = const EdgeInsets.only(left: 8, right: 8, top: 16),
    this.elevation = 0.0,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                description!,
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
}