import 'package:dart_prodata_util/src/pro-config.dart';
import 'package:flutter/material.dart';

class UtilTheme {
  /// Cria uma configuração de tema de alguns componentes da biblioteca [dart_prodata_util].

  late CustomLabelTheme customLabelTheme;
  late CustomCardTheme customCardTheme;
  late GenericDialogTheme genericDialogTheme;
  late CustomBottomSheetTheme customBottomSheetTheme;
  late Widget loadingProgressIndicator;

  UtilTheme(context, {
    CustomLabelTheme? customLabelTheme,
    CustomCardTheme? customCardTheme,
    GenericDialogTheme? genericDialogTheme,
    CustomBottomSheetTheme? customBottomSheetTheme,
    Widget? loadingProgressIndicator,
  }) {
    this.customLabelTheme = customLabelTheme ?? CustomLabelTheme(context);
    this.customCardTheme = customCardTheme ?? CustomCardTheme(context);
    this.genericDialogTheme = genericDialogTheme ?? GenericDialogTheme(context);
    this.customBottomSheetTheme = customBottomSheetTheme ?? CustomBottomSheetTheme(context);
    this.loadingProgressIndicator = loadingProgressIndicator ?? const CircularProgressIndicator();
  }
}

class CustomLabelTheme {
  /// Configura o tema da [CustomLabel].

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
  /// Cria um tema do [CustomCard].

  late TextStyle titleStyle;
  late TextStyle descriptionStyle;

  CustomCardTheme(context, {TextStyle? titleStyle, TextStyle? descriptionStyle}){
    this.titleStyle = titleStyle ?? TextStyle(
      fontSize: ProConfig.choseSize(16,18),
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
  /// Cria um tema do [GenericDialog].

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

class CustomBottomSheetTheme {
  /// Cria um tema da [CustomBottomSheet].

  late TextStyle titleStyle;
  late TextStyle descriptionStyle;

  CustomBottomSheetTheme(context, {TextStyle? titleStyle, TextStyle? descriptionStyle}){
    this.titleStyle = titleStyle ?? TextStyle(
      color: Theme.of(context).primaryColor,
      fontSize: ProConfig.choseSize(18, 22),
      fontWeight: FontWeight.w500,
    );

    this.descriptionStyle = descriptionStyle ?? TextStyle(
      fontSize: 14,
      color: Theme.of(context).colorScheme.onBackground.withAlpha(95),
      fontWeight: FontWeight.w400,
    );
  }
}