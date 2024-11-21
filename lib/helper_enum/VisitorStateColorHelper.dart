import 'package:flutter/material.dart';

class VisitorStateColorHelper {
  static const Map<int, Color> stateColors = {
    0: Colors.orange,   // Programado
    1: Colors.green,    // Aprobado
    2: Colors.red,      // Cancelado
  };

  static Color getColor(num? state) {
    int? stateInt = state?.toInt();
    return stateColors[stateInt ?? -1] ?? Colors.grey;
  }
}
