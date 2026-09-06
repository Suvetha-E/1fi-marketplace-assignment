import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../models/shop_models.dart';
import '../repositories/marketplace_repository.dart';
import '../repositories/shop_repository.dart';
import '../widgets/state_views.dart';
import 'product_details_screen.dart';

class ShopPage extends StatefulWidget {
  final int initialTabIndex;
  const ShopPage({super.key, this.initialTabIndex = 2});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  final ShopRepository _shopRepository = ShopRepository();
  final MarketplaceRepository _marketplaceRepository = MarketplaceRepository();

  late Future<List<Brand>> _brandsFuture;
  late Future<List<Store>> _storesFuture;
  late Future<List<Product>> _productsFuture;

  final String _selectedBrandCategory = 'All';
  String _selectedMarketplaceCategory = 'All';
  final TextEditingController _storeSearchController = TextEditingController();
  final TextEditingController _marketplaceSearchController = TextEditingController();

  final List<String> _marketplaceCategories = [
    'All',
    'Smartphones',
    'Laptops',
    'Audio',
    'Wearables',
    'Gaming',
  ];

  @override
  void initState() {
    super.initState();
    _loadAllData();
  }

  void _loadAllData() {
    setState(() {
      _brandsFuture = _shopRepository.fetchTopBrands(categoryFilter: _selectedBrandCategory);
      _storesFuture = _shopRepository.fetchNearbyStores(searchQuery: _storeSearchController.text.trim());
      _productsFuture = _marketplaceRepository.fetchProducts(
        category: _selectedMarketplaceCategory,
        searchQuery: _marketplaceSearchController.text.trim(),
      );
    });
  }

  @override
  void dispose() {
    _storeSearchController.dispose();
    _marketplaceSearchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: widget.initialTabIndex,
      child: Scaffold(
        backgroundColor: const Color(0xFFF8FAFC),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            'Shop',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Color(0xFF0F172A),
            ),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(48),
            child: Container(
              color: Colors.white,
              child: const TabBar(
                labelColor: Color(0xFF6B21A8),
                unselectedLabelColor: Color(0xFF64748B),
                indicatorColor: Color(0xFF6B21A8),
                indicatorWeight: 3,
                labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
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
            // Tab 1: Top Brands (Rich Implementation)
            _buildTopBrandsTab(),

            // Tab 2: Nearby Stores (Rich Implementation)
            _buildNearbyStoresTab(),

            // Tab 3: 1Fi Marketplace (Rich Implementation)
            _build1FiMarketplaceTab(),
          ],
        ),
      ),
    );
  }

  // TAB 1: TOP BRANDS
  Widget _buildTopBrandsTab() {
    return FutureBuilder<List<Brand>>(
      future: _brandsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingView(message: 'Loading partner top brands...');
        } else if (snapshot.hasError) {
          return ErrorView(message: 'Failed to load top brands.', onRetry: _loadAllData);
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const EmptyView(title: 'No Brands Found');
        }

        final brands = snapshot.data!;
        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF0F172A), Color(0xFF1E293B)],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      color: Color(0xFF059669),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.stars_rounded, color: Colors.white, size: 22),
                  ),
                  const SizedBox(width: 14),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Official 1Fi Brand Partners',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Exclusive 0% No-Cost EMI & instant cashback from top electronics brands.',
                          style: TextStyle(color: Color(0xFFCBD5E1), fontSize: 11, height: 1.3),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Featured Partner Brands',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Color(0xFF0F172A)),
            ),
            const SizedBox(height: 12),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.3,
              ),
              itemCount: brands.length,
              itemBuilder: (context, index) {
                final brand = brands[index];
                final bgColor = Color(int.parse(brand.backgroundColorHex));

                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: bgColor.withAlpha(50),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            brand.name,
                            style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          if (brand.hasNoCostEmi)
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: const Color(0xFF059669),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Text(
                                '0% EMI',
                                style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold),
                              ),
                            ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(brand.category, style: TextStyle(color: Colors.white.withAlpha(200), fontSize: 11)),
                          const SizedBox(height: 2),
                          Text(
                            brand.offerText,
                            style: const TextStyle(color: Color(0xFFFBBF24), fontSize: 11, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  // TAB 2: NEARBY STORES
  Widget _buildNearbyStoresTab() {
    return Column(
      children: [
        Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: TextField(
            controller: _storeSearchController,
            onChanged: (val) => _loadAllData(),
            decoration: InputDecoration(
              hintText: 'Search nearby stores or location...',
              hintStyle: const TextStyle(fontSize: 13, color: Color(0xFF94A3B8)),
              prefixIcon: const Icon(Icons.search_rounded, color: Color(0xFF64748B)),
              suffixIcon: _storeSearchController.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear_rounded, size: 18),
                      onPressed: () {
                        _storeSearchController.clear();
                        _loadAllData();
                      },
                    )
                  : null,
              fillColor: const Color(0xFFF1F5F9),
              filled: true,
              contentPadding: const EdgeInsets.symmetric(vertical: 10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        const Divider(height: 1, color: Color(0xFFE2E8F0)),
        Expanded(
          child: FutureBuilder<List<Store>>(
            future: _storesFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const LoadingView(message: 'Locating authorized retail partners...');
              } else if (snapshot.hasError) {
                return ErrorView(message: 'Failed to load nearby stores.', onRetry: _loadAllData);
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return EmptyView(
                  title: 'No Outlets Found',
                  message: 'No retail outlets matching "${_storeSearchController.text}"',
                  actionLabel: 'Reset Search',
                  onAction: () {
                    _storeSearchController.clear();
                    _loadAllData();
                  },
                );
              }

              final stores = snapshot.data!;
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: stores.length,
                itemBuilder: (context, index) {
                  final store = stores[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x08000000),
                          blurRadius: 8,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF3E8FF),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(Icons.storefront_rounded, color: Color(0xFF6B21A8), size: 24),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      store.name,
                                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFF0F172A)),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFFEF3C7),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      store.rating,
                                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: Color(0xFFD97706)),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                store.category,
                                style: const TextStyle(color: Color(0xFF6B21A8), fontSize: 11, fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                store.address,
                                style: const TextStyle(color: Color(0xFF64748B), fontSize: 12),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  const Icon(Icons.near_me_rounded, size: 13, color: Color(0xFF0284C7)),
                                  const SizedBox(width: 4),
                                  Text(
                                    store.formattedDistance,
                                    style: const TextStyle(color: Color(0xFF0284C7), fontSize: 11, fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(width: 12),
                                  Icon(
                                    Icons.circle,
                                    size: 8,
                                    color: store.isOpen ? const Color(0xFF059669) : const Color(0xFFDC2626),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    store.isOpen ? 'Open Now' : 'Closed',
                                    style: TextStyle(
                                      color: store.isOpen ? const Color(0xFF059669) : const Color(0xFFDC2626),
                                      fontSize: 11,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  // TAB 3: 1FI MARKETPLACE
  Widget _build1FiMarketplaceTab() {
    return Column(
      children: [
        // Search & Category Filter Section
        Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Column(
            children: [
              TextField(
                controller: _marketplaceSearchController,
                onChanged: (val) => _loadAllData(),
                decoration: InputDecoration(
                  hintText: 'Search 1Fi Marketplace (e.g. iPhone, MacBook, Sony)...',
                  hintStyle: const TextStyle(fontSize: 13, color: Color(0xFF94A3B8)),
                  prefixIcon: const Icon(Icons.search_rounded, color: Color(0xFF64748B)),
                  suffixIcon: _marketplaceSearchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear_rounded, size: 18),
                          onPressed: () {
                            _marketplaceSearchController.clear();
                            _loadAllData();
                          },
                        )
                      : null,
                  fillColor: const Color(0xFFF1F5F9),
                  filled: true,
                  contentPadding: const EdgeInsets.symmetric(vertical: 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              // Category Choice Chips
              SizedBox(
                height: 34,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _marketplaceCategories.length,
                  itemBuilder: (context, index) {
                    final cat = _marketplaceCategories[index];
                    final isSelected = _selectedMarketplaceCategory == cat;

                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ChoiceChip(
                        label: Text(cat),
                        selected: isSelected,
                        onSelected: (selected) {
                          if (selected) {
                            setState(() {
                              _selectedMarketplaceCategory = cat;
                              _loadAllData();
                            });
                          }
                        },
                        selectedColor: const Color(0xFF6B21A8),
                        backgroundColor: const Color(0xFFF1F5F9),
                        labelStyle: TextStyle(
                          color: isSelected ? Colors.white : const Color(0xFF475569),
                          fontSize: 12,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                        ),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        showCheckmark: false,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),

        const Divider(height: 1, color: Color(0xFFE2E8F0)),

        // Dynamic Product List with Async State Handling
        Expanded(
          child: FutureBuilder<List<Product>>(
            future: _productsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const LoadingView(message: 'Loading 1Fi Marketplace products...');
              } else if (snapshot.hasError) {
                return ErrorView(
                  message: 'Failed to fetch 1Fi Marketplace data.',
                  onRetry: _loadAllData,
                );
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return EmptyView(
                  title: 'No Marketplace Products Found',
                  message: 'Try adjusting your search query or selected category filter.',
                  actionLabel: 'Reset Filters',
                  onAction: () {
                    _marketplaceSearchController.clear();
                    setState(() {
                      _selectedMarketplaceCategory = 'All';
                      _loadAllData();
                    });
                  },
                );
              }

              final products = snapshot.data!;
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x08000000),
                          blurRadius: 8,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(16),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(16),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductDetailsScreen(product: product),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(14),
                          child: Row(
                            children: [
                              Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.network(
                                      product.imageUrl,
                                      width: 88,
                                      height: 88,
                                      fit: BoxFit.cover,
                                      errorBuilder: (ctx, err, stack) => Container(
                                        width: 88,
                                        height: 88,
                                        color: const Color(0xFFF1F5F9),
                                        child: const Icon(Icons.image_not_supported_rounded, color: Color(0xFF94A3B8)),
                                      ),
                                    ),
                                  ),
                                  if (product.emiPlans.any((p) => p.isNoCost))
                                    Positioned(
                                      top: 4,
                                      left: 4,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF059669),
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                        child: const Text(
                                          '0% EMI',
                                          style: TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFF3E8FF),
                                            borderRadius: BorderRadius.circular(4),
                                          ),
                                          child: Text(
                                            product.category.toUpperCase(),
                                            style: const TextStyle(color: Color(0xFF6B21A8), fontSize: 9, fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            const Icon(Icons.star_rounded, size: 14, color: Color(0xFFF59E0B)),
                                            const SizedBox(width: 2),
                                            Text(
                                              '${product.rating}',
                                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: Color(0xFF334155)),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      product.name,
                                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFF0F172A)),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 3),
                                    Text(
                                      '₹${product.basePrice.toStringAsFixed(0)}',
                                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFF334155)),
                                    ),
                                    const SizedBox(height: 3),
                                    Text(
                                      'EMI starting @ ₹${product.emiPlans.isNotEmpty ? product.emiPlans.first.monthlyAmount.toStringAsFixed(0) : '0'}/mo',
                                      style: const TextStyle(color: Color(0xFF059669), fontSize: 11, fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 4),
                              const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: Color(0xFF94A3B8)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}