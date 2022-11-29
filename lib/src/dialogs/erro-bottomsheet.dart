import 'package:dart_prodata_util/src/components/custom-bottomsheet.dart';
import 'package:dart_prodata_util/src/models/app-error.dart';
import 'package:flutter/material.dart';

void showErrorBottomSheet(BuildContext context, {required AppError appError, VoidCallback? onFinish}) {
  customBottomSheet(
    context,
    title: "Falha no envio",
    isDismissible: false,
    child: Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.end,
        alignment: WrapAlignment.end,
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height*.4,),
            child: ListView.separated(
              shrinkWrap: true,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (_, index) => Text(
                "- ${appError.details[index].message}",
                style: const TextStyle(fontSize: 16, color: Colors.black54),
                textAlign: TextAlign.justify,
              ),
              itemCount: appError.details.length,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: ElevatedButton(
              onPressed: () => _fechar(context, onFinish: onFinish),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red[800]),
              ),
              child: const Text(
                'Fechar',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          )
        ],
      ),
    ),
  );
}

void _fechar(BuildContext context, {VoidCallback? onFinish}) {
  Navigator.pop(context);
  if (onFinish != null) {
    onFinish();
  }
}