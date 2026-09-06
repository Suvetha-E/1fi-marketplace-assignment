import 'package:flutter/material.dart';
import '../models/shop_models.dart';
import '../repositories/shop_repository.dart';
import '../widgets/state_views.dart';
import 'marketplace_home_screen.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  final ShopRepository _shopRepository = ShopRepository();
  late Future<List<Brand>> _brandsFuture;
  late Future<List<Store>> _storesFuture;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    setState(() {
      _brandsFuture = _shopRepository.fetchTopBrands();
      _storesFuture = _shopRepository.fetchNearbyStores();
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Shop 1Fi', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(48),
            child: Container(
              color: Colors.white,
              child: const TabBar(
                labelColor: Color(0xFF6B21A8),
                unselectedLabelColor: Color(0xFF64748B),
                indicatorColor: Color(0xFF6B21A8),
                indicatorWeight: 3,
                labelStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                tabs: [
                  Tab(text: 'Top Brands'),
                  Tab(text: 'Nearby Stores'),
                  Tab(text: '1Fi Marketplace'),
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            // A. Top Brands (Dynamic)
            FutureBuilder<List<Brand>>(
              future: _brandsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const LoadingView();
                } else if (snapshot.hasError) {
                  return ErrorView(message: 'Failed to load top brands.', onRetry: _loadData);
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const EmptyView();
                }

                final brands = snapshot.data!;
                return ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    const Text('Partner Brands with No-Cost EMI', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Color(0xFF0F172A))),
                    const SizedBox(height: 12),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 1.4,
                      ),
                      itemCount: brands.length,
                      itemBuilder: (context, index) {
                        final brand = brands[index];
                        return Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Color(int.parse(brand.backgroundColorHex)),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(brand.name, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                              const SizedBox(height: 4),
                              Text(brand.subtitle, style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 11)),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                );
              },
            ),
            
            // B. Nearby Stores (Dynamic)
            FutureBuilder<List<Store>>(
              future: _storesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const LoadingView();
                } else if (snapshot.hasError) {
                  return ErrorView(message: 'Failed to load nearby stores.', onRetry: _loadData);
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const EmptyView();
                }

                final stores = snapshot.data!;
                return ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    const Text('Authorized Retail Outlets Nearby', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Color(0xFF0F172A))),
                    const SizedBox(height: 12),
                    ...stores.map((store) => Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(store.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Color(0xFF0F172A))),
                                const SizedBox(height: 4),
                                Text(store.details, style: const TextStyle(color: Color(0xFF64748B), fontSize: 12)),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF1F5F9),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(store.rating, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Color(0xFF0F172A))),
                          ),
                        ],
                      ),
                    )),
                  ],
                );
              },
            ),
            
            // C. 1Fi Marketplace Entry Tab
            SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF6B21A8), Color(0xFF9333EA)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF6B21A8).withOpacity(0.25),
                          blurRadius: 12,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.flash_on, color: Colors.amber, size: 28),
                        const SizedBox(height: 12),
                        const Text(
                          'Instant Credit & No-Cost EMIs',
                          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          'Shop top tech products with flexible tenure options tailored directly through 1Fi.',
                          style: TextStyle(color: Colors.white70, fontSize: 13, height: 1.4),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: const Color(0xFF6B21A8),
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            elevation: 0,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const MarketplaceHomeScreen()),
                            );
                          },
                          child: const Text('Explore 1Fi Marketplace', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}