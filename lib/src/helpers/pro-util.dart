import 'package:flutter/material.dart';

class ProUtil {
  /// Funçoes utilitárias diversas

  /// Compara dois [TimeOfDay], retornando -1 se [time] for menor que [other], 0 se forem iguais e 1 se [time] for maior que [other].
  int compareTime(TimeOfDay time, TimeOfDay other) {
    if (time.hour < other.hour) return -1;
    if (time.hour > other.hour) return 1;
    if (time.minute < other.minute) return -1;
    if (time.minute > other.minute) return 1;
    return 0;
  }

  /// Converte um [Color] para uma [String] com seu valor em hexadecimal.
  String getHexColor(Color color) {
    return '#${color.red.toRadixString(16).padLeft(2, '0')}'
        '${color.green.toRadixString(16).padLeft(2, '0')}'
        '${color.blue.toRadixString(16).padLeft(2, '0')}';
  }
}