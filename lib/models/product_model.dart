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
  final bool isPopular;

  EMIPlan({
    required this.months,
    required this.monthlyAmount,
    required this.interestRate,
    this.isPopular = false,
  });
}

class Product {
  final String id;
  final String name;
  final String category;
  final double basePrice;
  final String imageUrl;
  final String description;
  final List<ProductVariant> variants;
  final List<EMIPlan> emiPlans;

  Product({
    required this.id,
    required this.name,
    required this.category,
    required this.basePrice,
    required this.imageUrl,
    required this.description,
    required this.variants,
    required this.emiPlans,
  });
}