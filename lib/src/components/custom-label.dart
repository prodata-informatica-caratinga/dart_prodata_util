import 'package:dart_prodata_util/src/components/custom-bottomsheet.dart';
import 'package:dart_prodata_util/src/config.dart';
import 'package:flutter/material.dart';

class CustomLabel extends StatelessWidget {
  final String title;
  String? subtitle;
  Widget? child;
  CustomLabelHelp? help;

  CustomLabel({required this.title, this.subtitle, this.child, this.help, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Config.utilTheme.customLabelTheme.titleStyle,
          ),

          subtitle != null ? Row(
            children: [
              Flexible(
                fit: FlexFit.loose,
                child: Text(
                  subtitle!,
                  overflow: TextOverflow.ellipsis,
                  style: Config.utilTheme.customLabelTheme.subtitleStyle,
                ),
              ),
            ],
          ) : Container(),

          if (help != null)
            InkWell(
              child: const Text('Saiba mais', style: TextStyle(color: Colors.blue)),
              onTap: () {
                customBottomSheet(help!.context,
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
  BuildContext context;
  String help;

  CustomLabelHelp(this.context, this.help);
}