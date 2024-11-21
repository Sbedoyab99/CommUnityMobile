class VisitorStateHelper {
  static const Map<int, String> descriptions = {
    0: 'Programado',
    1: 'Aprobado',
    2: 'Cancelado',
  };

  static String getDescription(num? state) {
    int? stateInt = state?.toInt();
    return descriptions[stateInt ?? -1] ?? 'Sin estado';
  }
}