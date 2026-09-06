class ProductVariant {
  final String id;
  final String name;
  final double priceExtra;

  ProductVariant({
    required this.id,
    required this.name,
    this.priceExtra = 0.0,
  });
}

class EMIPlan {
  final int months;
  final double monthlyAmount;
  final double interestRate;
  final double downPayment;
  final bool isPopular;
  final bool isNoCost;

  EMIPlan({
    required this.months,
    required this.monthlyAmount,
    required this.interestRate,
    this.downPayment = 0.0,
    this.isPopular = false,
    this.isNoCost = false,
  });
}

class Product {
  final String id;
  final String name;
  final String brand;
  final String category;
  final double basePrice;
  final String imageUrl;
  final List<String> galleryImages;
  final String description;
  final Map<String, String> specs;
  final List<ProductVariant> variants;
  final List<EMIPlan> emiPlans;
  final double rating;
  final int reviewCount;

  Product({
    required this.id,
    required this.name,
    required this.brand,
    required this.category,
    required this.basePrice,
    required this.imageUrl,
    this.galleryImages = const [],
    required this.description,
    this.specs = const {},
    required this.variants,
    required this.emiPlans,
    this.rating = 4.8,
    this.reviewCount = 124,
  });
}