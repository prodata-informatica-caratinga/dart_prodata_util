import 'package:dart_prodata_util/src/config.dart';
import 'package:flutter/material.dart';

customBottomSheet(BuildContext context, {required Widget child, String? title, bool isDismissible = true, String? description, Color? titleColor}) {
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
          style: TextStyle(color: color ?? Theme.of(context).primaryColor, fontSize: Config.choseSize(18, 22), fontWeight: FontWeight.w500),
        ),
        const Divider(),
        description != null
          ? Text(
            description,
            textAlign: TextAlign.justify,
            style: TextStyle(color: Theme.of(context).primaryColor, fontSize: Config.choseSize(14, 16)),
          )
          : Container(),
      ],
    ),
  );
}
