class Brand {
  final String id;
  final String name;
  final String category;
  final String subtitle;
  final String offerText;
  final String backgroundColorHex;
  final bool hasNoCostEmi;

  Brand({
    required this.id,
    required this.name,
    required this.category,
    required this.subtitle,
    required this.offerText,
    required this.backgroundColorHex,
    this.hasNoCostEmi = true,
  });
}

class Store {
  final String id;
  final String name;
  final String category;
  final String address;
  final double distanceKm;
  final String rating;
  final bool isOpen;

  Store({
    required this.id,
    required this.name,
    required this.category,
    required this.address,
    required this.distanceKm,
    required this.rating,
    this.isOpen = true,
  });

  String get formattedDistance => '${distanceKm.toStringAsFixed(1)} km away';
}