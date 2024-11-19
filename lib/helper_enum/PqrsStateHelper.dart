class PqrsStateHelper {
  static const Map<int, String> descriptions = {
    0: 'Radicada',
    1: 'En Revisión',
    2: 'En Progreso',
    3: 'Resuelta',
    4: 'Cerrada',
  };

  static String getDescription(num? state) {
    int? stateInt = state?.toInt();
    return descriptions[stateInt ?? -1] ?? 'Sin estado';
  }
}