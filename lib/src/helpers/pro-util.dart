import 'package:flutter/material.dart';

class ProUtil {
  int compareTime(TimeOfDay time, TimeOfDay other) {
    if (time.hour < other.hour) return -1;
    if (time.hour > other.hour) return 1;
    if (time.minute < other.minute) return -1;
    if (time.minute > other.minute) return 1;
    return 0;
  }

  String getHexColor(Color color) {
    return '#${color.red.toRadixString(16).padLeft(2, '0')}'
        '${color.green.toRadixString(16).padLeft(2, '0')}'
        '${color.blue.toRadixString(16).padLeft(2, '0')}';
  }
}