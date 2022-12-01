import 'package:dart_prodata_util/src/components/custom-bottomsheet.dart';
import 'package:dart_prodata_util/src/pro-config.dart';
import 'package:flutter/material.dart';

class CustomLabel extends StatelessWidget {
  /// Cria um [Widget] que suporta um título, subtítulo, um [Widget] filho e um botão de ajuda, onde será aberto um [showCustomBottomSheet] exibindo o texto informado.
  ///
  /// O argumento [title] não pode ser nulo.

  final String title;
  String? subtitle;
  Widget? child;
  CustomLabelHelp? help;

  CustomLabel({required this.title, this.subtitle, this.child, this.help, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    assert(ProConfig.navigatorKey.currentContext != null, 'Context não encontrado. Verifique se a navigatorKey está definida no MaterialApp.');
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: ProConfig.utilTheme.customLabelTheme.titleStyle,
          ),

          subtitle != null ? Row(
            children: [
              Flexible(
                fit: FlexFit.loose,
                child: Text(
                  subtitle!,
                  overflow: TextOverflow.ellipsis,
                  style: ProConfig.utilTheme.customLabelTheme.subtitleStyle,
                ),
              ),
            ],
          ) : Container(),

          if (help != null)
            InkWell(
              child: const Text('Saiba mais', style: TextStyle(color: Colors.blue)),
              onTap: () {
                showCustomBottomSheet(help!.context,
                  title: title,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(help!.help, textAlign: TextAlign.justify),
                  ),
                );
              },
            ),

          if (child != null) child!
        ],
      ),
    );
  }
}

class CustomLabelHelp {
  /// Recebe o context e um texto de ajuda que será exibido no [CustomLabel].

  BuildContext context;
  String help;

  CustomLabelHelp(this.context, this.help);
}