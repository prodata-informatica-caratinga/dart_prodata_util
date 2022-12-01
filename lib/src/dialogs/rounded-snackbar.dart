import 'package:dart_prodata_util/src/pro-config.dart';
import 'package:flutter/material.dart';

/// Cria uma [SnackBar] com bordas arredondadas.
///
/// O argumento [title] não pode ser nulo.
SnackBar roundedSnackBar(String title, {
  double? fontSize,
  Color? fontColor,
  int? seconds,
  IconData? icon,
  Color? iconColor,
  SnackBarAction? action,
  Color? backgroundColor,
}){
  return SnackBar(
    action: action,
    content: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          if(icon != null) Padding(
            padding: EdgeInsets.symmetric(horizontal: ProConfig.choseSize(0, 14)),
            child: Icon(icon, color: iconColor),
          ),
          Flexible(
            child: Text(
              title,
              style: TextStyle(
                fontSize: fontSize ?? ProConfig.choseSize(16, 18),
                color: fontColor ?? Colors.white,
              ),
            ),
          ),
        ],
      ),
    ),
    duration: Duration(seconds: seconds ?? 2),
    width: ProConfig.screenWidth - 40,
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    backgroundColor: backgroundColor ?? Colors.blue,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(100),
    ),
  );
}