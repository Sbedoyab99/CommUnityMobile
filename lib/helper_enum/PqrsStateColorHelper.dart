import 'package:flutter/material.dart';

class PqrsStateColorHelper {
  static const Map<int, Color> stateColors = {
    0: Colors.red,           // Radicada
    1: Colors.orange,        // En Revisión
    2: Colors.yellow,        // En Progreso
    3: Colors.green,         // Resuelta
    4: Colors.greenAccent,   // Cerrada
  };

  static Color getColor(num? state) {
    int? stateInt = state?.toInt(); // Convertir num? a int?
    return stateColors[stateInt ?? -1] ?? Colors.grey; // Devuelve gris si no encuentra el estado
  }
}