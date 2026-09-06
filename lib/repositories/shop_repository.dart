import '../models/shop_models.dart';

class ShopRepository {
  Future<List<Brand>> fetchTopBrands() async {
    await Future.delayed(const Duration(milliseconds: 600));
    return [
      Brand(id: 'b1', name: 'Apple', subtitle: 'Official Partner', backgroundColorHex: '0xFF000000'),
      Brand(id: 'b2', name: 'Samsung', subtitle: 'Exclusive Offers', backgroundColorHex: '0xFF0D47A1'),
      Brand(id: 'b3', name: 'Sony', subtitle: 'Audio & Gaming', backgroundColorHex: '0xFF212121'),
      Brand(id: 'b4', name: 'OnePlus', subtitle: 'Zero Down Payment', backgroundColorHex: '0xFFB71C1C'),
    ];
  }

  Future<List<Store>> fetchNearbyStores() async {
    await Future.delayed(const Duration(milliseconds: 600));
    return [
      Store(id: 's1', name: 'Croma Electronics', details: 'Velachery Main Road • 1.2 km away', rating: '4.8 ★'),
      Store(id: 's2', name: 'Reliance Digital', details: 'Phoenix MarketCity • 2.4 km away', rating: '4.6 ★'),
      Store(id: 's3', name: 'Poorvika Mobiles', details: 'Andavar Nagar • 3.0 km away', rating: '4.5 ★'),
    ];
  }
}