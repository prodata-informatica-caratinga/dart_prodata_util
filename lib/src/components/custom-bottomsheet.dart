import 'package:dart_prodata_util/src/pro-config.dart';
import 'package:flutter/material.dart';

/// Exibe um [BottomSheet] que suporta um [Widget] filho, um título, uma descrição e a cor do título.
///
/// Os argumentos [context] e [child] não podem ser nulos.
showCustomBottomSheet(BuildContext context, {required Widget child, String? title, bool isDismissible = true, String? description, Color? titleColor}) {
  assert(ProConfig.navigatorKey.currentContext != null, 'Context não encontrado. Verifique se a navigatorKey está definida no MaterialApp.');
  showModalBottomSheet(
    isScrollControlled: true,
    isDismissible: isDismissible,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))),
    context: context,
    builder: (context) {
      return Wrap(
        children: [
          title == null ? Container() : _title(context, title, description, titleColor),
          child,
        ],
      );
    },
  );
}

Widget _title(BuildContext context, String title, String? description, Color? color) {
  return Padding(
    padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: ProConfig.utilTheme.customBottomSheetTheme.titleStyle.copyWith(
            color: color,
          ),
        ),
        const Divider(),
        description != null
          ? Text(
            description,
            textAlign: TextAlign.justify,
            style: ProConfig.utilTheme.customBottomSheetTheme.descriptionStyle,
          ) : Container(),
      ],
    ),
  );
}