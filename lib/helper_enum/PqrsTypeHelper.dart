class PqrsTypeHelper {
  static const Map<int, String> descriptions = {
    0: 'Petición',
    1: 'Queja',
    2: 'Reclamo',
    3: 'Sugerencia',
  };

  static String getDescription(num? type) {
    int? typeInt = type?.toInt();
    return descriptions[typeInt ?? -1] ?? 'N/A';
  }
}