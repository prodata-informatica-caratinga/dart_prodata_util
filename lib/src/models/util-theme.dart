import 'package:dart_prodata_util/src/config.dart';
import 'package:flutter/material.dart';

class UtilTheme {
  late CustomLabelTheme customLabelTheme;
  late CustomCardTheme customCardTheme;
  late GenericDialogTheme genericDialogTheme;
  late Widget loadingProgressIndicator;

  UtilTheme(context, {
    CustomLabelTheme? customLabelTheme,
    CustomCardTheme? customCardTheme,
    GenericDialogTheme? genericDialogTheme,
    Widget? loadingProgressIndicator,
  }) {
    this.customLabelTheme = customLabelTheme ?? CustomLabelTheme(context);
    this.customCardTheme = customCardTheme ?? CustomCardTheme(context);
    this.genericDialogTheme = genericDialogTheme ?? GenericDialogTheme(context);
    this.loadingProgressIndicator = loadingProgressIndicator ?? const CircularProgressIndicator();
  }
}

class CustomLabelTheme {
  late TextStyle titleStyle;
  late TextStyle subtitleStyle;

  CustomLabelTheme(context, {TextStyle? titleStyle, TextStyle? subtitleStyle}){
    this.titleStyle = titleStyle ?? TextStyle(
      fontSize: 16,
      color: Theme.of(context).colorScheme.primary,
      fontWeight: FontWeight.w600,
    );

    this.subtitleStyle = subtitleStyle ?? TextStyle(
      fontSize: 14,
      color: Theme.of(context).colorScheme.onBackground.withAlpha(95),
      fontWeight: FontWeight.w300,
    );
  }
}

class CustomCardTheme {
  late TextStyle titleStyle;
  late TextStyle descriptionStyle;

  CustomCardTheme(context, {TextStyle? titleStyle, TextStyle? descriptionStyle}){
    this.titleStyle = titleStyle ?? TextStyle(
      fontSize: Config.choseSize(16,18),
      color: Theme.of(context).colorScheme.primary,
      fontWeight: FontWeight.w600,
    );

    this.descriptionStyle = descriptionStyle ?? TextStyle(
      fontSize: 14,
      color: Theme.of(context).colorScheme.onBackground.withAlpha(95),
      fontWeight: FontWeight.w400,
    );
  }
}

class GenericDialogTheme {
  late TextStyle titleStyle;
  late TextStyle messageStyle;
  late EdgeInsets padding;

  GenericDialogTheme(context, {TextStyle? titleStyle, TextStyle? messageStyle, EdgeInsets? padding}){
    this.titleStyle = titleStyle ?? TextStyle(
      color: Theme.of(context).colorScheme.primary,
      fontSize: 22,
      fontWeight: FontWeight.w600,
    );

    this.messageStyle = messageStyle ?? TextStyle(color: Theme.of(context).colorScheme.onBackground);
    this.padding = padding ?? const EdgeInsets.all(16);
  }
}