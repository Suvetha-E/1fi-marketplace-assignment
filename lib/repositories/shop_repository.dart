import '../models/shop_models.dart';

class ShopRepository {
  Future<List<Brand>> fetchTopBrands({String? categoryFilter}) async {
    await Future.delayed(const Duration(milliseconds: 600));
    final brands = [
      Brand(
        id: 'b1',
        name: 'Apple',
        category: 'Smartphones & Laptops',
        subtitle: 'Official Partner',
        offerText: 'Up to 24m No-Cost EMI',
        backgroundColorHex: '0xFF0F172A',
        hasNoCostEmi: true,
      ),
      Brand(
        id: 'b2',
        name: 'Samsung',
        category: 'Mobiles & TVs',
        subtitle: 'Exclusive Offers',
        offerText: 'Flat ₹5,000 Instant Discount',
        backgroundColorHex: '0xFF1E3A8A',
        hasNoCostEmi: true,
      ),
      Brand(
        id: 'b3',
        name: 'Sony',
        category: 'Audio & Gaming',
        subtitle: 'Premium Audio',
        offerText: '0 Down Payment',
        backgroundColorHex: '0xFF18181B',
        hasNoCostEmi: true,
      ),
      Brand(
        id: 'b4',
        name: 'OnePlus',
        category: 'Smartphones',
        subtitle: 'Never Settle',
        offerText: '0% Interest for 12m',
        backgroundColorHex: '0xFF991B1B',
        hasNoCostEmi: true,
      ),
      Brand(
        id: 'b5',
        name: 'Bose',
        category: 'Audio',
        subtitle: 'Acoustic Noise Cancelling',
        offerText: 'Special 1Fi Member Rate',
        backgroundColorHex: '0xFF312E81',
        hasNoCostEmi: true,
      ),
      Brand(
        id: 'b6',
        name: 'Dell Pro',
        category: 'Laptops',
        subtitle: 'Workstation & Gaming',
        offerText: 'Free Extended Warranty',
        backgroundColorHex: '0xFF0369A1',
        hasNoCostEmi: false,
      ),
    ];

    if (categoryFilter != null && categoryFilter != 'All') {
      return brands.where((b) => b.category.toLowerCase().contains(categoryFilter.toLowerCase())).toList();
    }
    return brands;
  }

  Future<List<Store>> fetchNearbyStores({String? searchQuery}) async {
    await Future.delayed(const Duration(milliseconds: 650));
    final stores = [
      Store(
        id: 's1',
        name: 'Croma Flagship Experience Store',
        category: 'Multi-Brand Electronics',
        address: 'Velachery Main Road, Near Grand Mall, Chennai',
        distanceKm: 1.2,
        rating: '4.8 ★',
        isOpen: true,
      ),
      Store(
        id: 's2',
        name: 'Reliance Digital Mega Store',
        category: 'Mobiles, Laptops & Appliances',
        address: 'Phoenix MarketCity Mall, Lower Ground, Chennai',
        distanceKm: 2.4,
        rating: '4.6 ★',
        isOpen: true,
      ),
      Store(
        id: 's3',
        name: 'Poorvika Mobiles & Tech Hub',
        category: 'Authorized Apple & Samsung Reseller',
        address: '128, Main Commercial Zone, Adyar',
        distanceKm: 3.1,
        rating: '4.7 ★',
        isOpen: true,
      ),
      Store(
        id: 's4',
        name: 'Imagine Apple Premium Reseller',
        category: 'Official Apple Store',
        address: 'Express Avenue Mall, First Floor, Chennai',
        distanceKm: 5.8,
        rating: '4.9 ★',
        isOpen: true,
      ),
      Store(
        id: 's5',
        name: 'Sony Center Premium Retail',
        category: 'Audio & PlayStation Authorized Outlet',
        address: 'Anna Nagar 2nd Avenue, Chennai',
        distanceKm: 7.2,
        rating: '4.5 ★',
        isOpen: false,
      ),
    ];

    if (searchQuery != null && searchQuery.isNotEmpty) {
      return stores.where((s) =>
          s.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
          s.category.toLowerCase().contains(searchQuery.toLowerCase()) ||
          s.address.toLowerCase().contains(searchQuery.toLowerCase())).toList();
    }

    return stores;
  }
}