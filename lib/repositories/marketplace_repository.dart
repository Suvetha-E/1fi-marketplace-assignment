import '../models/product_model.dart';

class MarketplaceRepository {
  Future<List<Product>> fetchProducts({
    String? category,
    String? searchQuery,
  }) async {
    await Future.delayed(const Duration(milliseconds: 700));

    final allProducts = [
      Product(
        id: 'prod_1',
        name: 'MacBook Pro 16" M3 Max',
        brand: 'Apple',
        category: 'Laptops',
        basePrice: 249999.0,
        imageUrl: 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=800',
        galleryImages: [
          'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=800',
          'https://images.unsplash.com/photo-1611186871348-b1ce696e52c9?w=800',
          'https://images.unsplash.com/photo-1541807084-5c52b6b3adef?w=800',
        ],
        description: 'Ultimate pro laptop featuring the revolutionary M3 Max chip with a 16-core CPU and 40-core GPU. Outfitted with a liquid Retina XDR display, up to 22 hours of battery life, and high-fidelity sound.',
        specs: {
          'Processor': 'Apple M3 Max (16-core CPU, 40-core GPU)',
          'RAM & Storage': '36GB Unified Memory, 1TB Superfast SSD',
          'Display': '16.2" Liquid Retina XDR (3456 x 2234, 120Hz ProMotion)',
          'Battery Life': 'Up to 22 hours wireless web browsing',
          'Warranty': '1 Year Apple Care India Warranty',
        },
        variants: [
          ProductVariant(id: 'v1', name: '36GB RAM / 1TB SSD'),
          ProductVariant(id: 'v2', name: '48GB RAM / 1TB SSD', priceExtra: 35000.0),
          ProductVariant(id: 'v3', name: '128GB RAM / 2TB SSD', priceExtra: 110000.0),
        ],
        emiPlans: [
          EMIPlan(months: 3, monthlyAmount: 83333.0, interestRate: 0.0, isNoCost: true),
          EMIPlan(months: 6, monthlyAmount: 41666.0, interestRate: 0.0, isNoCost: true, isPopular: true),
          EMIPlan(months: 12, monthlyAmount: 22150.0, interestRate: 11.5),
          EMIPlan(months: 18, monthlyAmount: 15420.0, interestRate: 12.5),
          EMIPlan(months: 24, monthlyAmount: 12050.0, interestRate: 13.5),
        ],
        rating: 4.9,
        reviewCount: 312,
      ),
      Product(
        id: 'prod_2',
        name: 'iPhone 15 Pro Max',
        brand: 'Apple',
        category: 'Smartphones',
        basePrice: 139999.0,
        imageUrl: 'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=800',
        galleryImages: [
          'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=800',
          'https://images.unsplash.com/photo-1592750475338-74b7b21085ab?w=800',
          'https://images.unsplash.com/photo-1565849904461-04a58ad377e0?w=800',
        ],
        description: 'Forged in aerospace-grade titanium, featuring the groundbreaking A17 Pro chip, customizable Action button, and the most powerful 5x optical telephoto iPhone camera system.',
        specs: {
          'Chipset': 'A17 Pro (3nm architecture)',
          'Camera': '48MP Main | 12MP Ultra Wide | 12MP 5x Telephoto',
          'Display': '6.7" Super Retina XDR OLED ProMotion 120Hz',
          'Build': 'Grade 5 Titanium frame with Ceramic Shield front',
          'Connectivity': 'USB-C (USB 3 speeds up to 10Gbps), 5G, Wi-Fi 6E',
        },
        variants: [
          ProductVariant(id: 'v1', name: '256GB Titanium Gray'),
          ProductVariant(id: 'v2', name: '512GB Titanium Black', priceExtra: 20000.0),
          ProductVariant(id: 'v3', name: '1TB Titanium Blue', priceExtra: 40000.0),
        ],
        emiPlans: [
          EMIPlan(months: 3, monthlyAmount: 46666.0, interestRate: 0.0, isNoCost: true),
          EMIPlan(months: 6, monthlyAmount: 23333.0, interestRate: 0.0, isNoCost: true, isPopular: true),
          EMIPlan(months: 12, monthlyAmount: 12450.0, interestRate: 11.0),
          EMIPlan(months: 18, monthlyAmount: 8680.0, interestRate: 12.0),
        ],
        rating: 4.8,
        reviewCount: 489,
      ),
      Product(
        id: 'prod_3',
        name: 'Sony WH-1000XM5 ANC Headphones',
        brand: 'Sony',
        category: 'Audio',
        basePrice: 29990.0,
        imageUrl: 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=800',
        galleryImages: [
          'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=800',
          'https://images.unsplash.com/photo-1484704849700-f032a568e944?w=800',
        ],
        description: 'Industry leading noise canceling with two processors and 8 microphones. Magnificent sound quality engineered with integrated V1 processor.',
        specs: {
          'Active Noise Cancelling': 'Dual Processor Auto NC Optimizer',
          'Battery Life': '30 Hours (NC ON), Quick charge (3 mins = 3 hours)',
          'Microphones': '8 Mics with Precise Voice Pickup AI',
          'Weight': '250g Ultra-light design',
        },
        variants: [
          ProductVariant(id: 'v1', name: 'Midnight Black'),
          ProductVariant(id: 'v2', name: 'Silver Platinum'),
          ProductVariant(id: 'v3', name: 'Smoky White Edition', priceExtra: 1500.0),
        ],
        emiPlans: [
          EMIPlan(months: 3, monthlyAmount: 9996.0, interestRate: 0.0, isNoCost: true, isPopular: true),
          EMIPlan(months: 6, monthlyAmount: 4998.0, interestRate: 0.0, isNoCost: true),
          EMIPlan(months: 9, monthlyAmount: 3520.0, interestRate: 9.5),
        ],
        rating: 4.7,
        reviewCount: 620,
      ),
      Product(
        id: 'prod_4',
        name: 'Samsung Galaxy Watch 6 Classic',
        brand: 'Samsung',
        category: 'Wearables',
        basePrice: 36999.0,
        imageUrl: 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=800',
        galleryImages: [
          'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=800',
        ],
        description: 'Classic rotating bezel design meets advanced wellness tracking, ECG heart analytics, continuous sleep coaching, and sapphire crystal glass.',
        specs: {
          'Display': '1.5" Super AMOLED Sapphire Crystal Glass',
          'Sensors': 'BioActive Sensor (ECG, BIA, HR), Infrared Temperature',
          'Battery': '425mAh Wireless Fast Charge',
          'Water Resistance': '5ATM + IP68 / MIL-STD-810H',
        },
        variants: [
          ProductVariant(id: 'v1', name: '47mm Bluetooth Stainless Steel'),
          ProductVariant(id: 'v2', name: '47mm LTE eSIM Cellular', priceExtra: 4000.0),
        ],
        emiPlans: [
          EMIPlan(months: 3, monthlyAmount: 12333.0, interestRate: 0.0, isNoCost: true),
          EMIPlan(months: 6, monthlyAmount: 6166.0, interestRate: 0.0, isNoCost: true, isPopular: true),
          EMIPlan(months: 12, monthlyAmount: 3280.0, interestRate: 10.5),
        ],
        rating: 4.6,
        reviewCount: 205,
      ),
      Product(
        id: 'prod_5',
        name: 'Sony PlayStation 5 Slim Digital',
        brand: 'Sony',
        category: 'Gaming',
        basePrice: 44990.0,
        imageUrl: 'https://images.unsplash.com/photo-1606813907291-d86efa9b94db?w=800',
        galleryImages: [
          'https://images.unsplash.com/photo-1606813907291-d86efa9b94db?w=800',
        ],
        description: 'Unleash new gaming possibilities with lightning fast loading with ultra-high speed SSD, deeper immersion with haptic feedback, and 4K 120Hz gaming.',
        specs: {
          'Storage': '1TB Custom Ultra-High Speed NVMe SSD',
          'Audio': '3D AudioTech tempest engine',
          'Output': 'Supports 4K 120Hz TVs, 8K output, HDR',
        },
        variants: [
          ProductVariant(id: 'v1', name: 'Digital Edition (1TB SSD)'),
          ProductVariant(id: 'v2', name: 'Disc Drive Edition', priceExtra: 9000.0),
        ],
        emiPlans: [
          EMIPlan(months: 3, monthlyAmount: 14996.0, interestRate: 0.0, isNoCost: true),
          EMIPlan(months: 6, monthlyAmount: 7498.0, interestRate: 0.0, isNoCost: true, isPopular: true),
          EMIPlan(months: 12, monthlyAmount: 3990.0, interestRate: 11.0),
        ],
        rating: 4.9,
        reviewCount: 840,
      ),
      Product(
        id: 'prod_6',
        name: 'Bose QuietComfort Ultra Earbuds',
        brand: 'Bose',
        category: 'Audio',
        basePrice: 25900.0,
        imageUrl: 'https://images.unsplash.com/photo-1590658268037-6bf12165a8df?w=800',
        galleryImages: [
          'https://images.unsplash.com/photo-1590658268037-6bf12165a8df?w=800',
        ],
        description: 'Breakthrough spatialized audio for immersive listening, world-class noise cancellation tuned specifically to your ear canal shape.',
        specs: {
          'Spatial Audio': 'Immersive Audio mode with head tracking',
          'Noise Control': 'Quiet, Aware, & Immersion modes',
          'Battery': '6 hours listening + 18 hours in case',
        },
        variants: [
          ProductVariant(id: 'v1', name: 'Black Edition'),
          ProductVariant(id: 'v2', name: 'White Smoke'),
        ],
        emiPlans: [
          EMIPlan(months: 3, monthlyAmount: 8633.0, interestRate: 0.0, isNoCost: true, isPopular: true),
          EMIPlan(months: 6, monthlyAmount: 4316.0, interestRate: 0.0, isNoCost: true),
        ],
        rating: 4.7,
        reviewCount: 198,
      ),
    ];

    List<Product> filtered = List.from(allProducts);

    if (category != null && category.isNotEmpty && category != 'All') {
      filtered = filtered.where((p) => p.category.toLowerCase() == category.toLowerCase()).toList();
    }

    if (searchQuery != null && searchQuery.isNotEmpty) {
      final query = searchQuery.toLowerCase();
      filtered = filtered.where((p) =>
          p.name.toLowerCase().contains(query) ||
          p.brand.toLowerCase().contains(query) ||
          p.category.toLowerCase().contains(query) ||
          p.description.toLowerCase().contains(query)).toList();
    }

    return filtered;
  }
}