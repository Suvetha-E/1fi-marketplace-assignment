import '../models/product_model.dart';

class MarketplaceRepository {
  Future<List<Product>> fetchProducts() async {
    await Future.delayed(const Duration(milliseconds: 800));
    
    return [
      Product(
        id: 'prod_1',
        name: 'MacBook Pro 16" M3 Max',
        category: 'Laptops',
        basePrice: 249999.0,
        imageUrl: 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=600',
        description: 'Ultimate pro laptop with extreme performance, stunning Liquid Retina XDR display, and all-day battery life.',
        variants: [
          ProductVariant(id: 'v1', name: '512GB SSD / 16GB RAM'),
          ProductVariant(id: 'v2', name: '1TB SSD / 32GB RAM', priceExtra: 30000.0),
          ProductVariant(id: 'v3', name: '2TB SSD / 64GB RAM', priceExtra: 85000.0),
        ],
        emiPlans: [
          EMIPlan(months: 3, monthlyAmount: 85500.0, interestRate: 0.0),
          EMIPlan(months: 6, monthlyAmount: 43500.0, interestRate: 11.5, isPopular: true),
          EMIPlan(months: 12, monthlyAmount: 22800.0, interestRate: 13.0),
        ],
      ),
      Product(
        id: 'prod_2',
        name: 'iPhone 17 Pro Max',
        category: 'Smartphones',
        basePrice: 139999.0,
        imageUrl: 'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=600',
        description: 'Titanium design, powerful A-series chip, breakthrough telephoto camera system, and advanced action capabilities.',
        variants: [
          ProductVariant(id: 'v1', name: '256GB Storage'),
          ProductVariant(id: 'v2', name: '512GB Storage', priceExtra: 20000.0),
        ],
        emiPlans: [
          EMIPlan(months: 3, monthlyAmount: 47850.0, interestRate: 0.0),
          EMIPlan(months: 6, monthlyAmount: 24350.0, interestRate: 10.5, isPopular: true),
          EMIPlan(months: 12, monthlyAmount: 12800.0, interestRate: 12.0),
        ],
      ),
      Product(
        id: 'prod_3',
        name: 'Sony WH-1000XM5 Headphones',
        category: 'Audio',
        basePrice: 29990.0,
        imageUrl: 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=600',
        description: 'Industry-leading noise cancellation with two processors and 8 microphones for pristine sound and crystal clear calls.',
        variants: [
          ProductVariant(id: 'v1', name: 'Midnight Black'),
          ProductVariant(id: 'v2', name: 'Silver Platinum'),
        ],
        emiPlans: [
          EMIPlan(months: 3, monthlyAmount: 10250.0, interestRate: 0.0, isPopular: true),
          EMIPlan(months: 6, monthlyAmount: 5300.0, interestRate: 9.0),
        ],
      ),
    ];
  }
}