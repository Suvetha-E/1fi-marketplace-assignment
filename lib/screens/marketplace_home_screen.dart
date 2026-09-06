import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../repositories/marketplace_repository.dart';
import '../widgets/state_views.dart';
import 'product_details_screen.dart';

class MarketplaceHomeScreen extends StatefulWidget {
  const MarketplaceHomeScreen({super.key});

  @override
  State<MarketplaceHomeScreen> createState() => _MarketplaceHomeScreenState();
}

class _MarketplaceHomeScreenState extends State<MarketplaceHomeScreen> {
  final MarketplaceRepository _repository = MarketplaceRepository();
  late Future<List<Product>> _productsFuture;

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  void _loadProducts() {
    setState(() {
      _productsFuture = _repository.fetchProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('1Fi Marketplace', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      ),
      body: FutureBuilder<List<Product>>(
        future: _productsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingView();
          } else if (snapshot.hasError) {
            return ErrorView(message: 'Failed to load marketplace products.', onRetry: _loadProducts);
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const EmptyView();
          }

          final products = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.02),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
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
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(product.imageUrl, width: 88, height: 88, fit: BoxFit.cover),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF3E8FF),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    product.category.toUpperCase(),
                                    style: const TextStyle(color: Color(0xFF6B21A8), fontSize: 10, fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  product.name,
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Color(0xFF0F172A)),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '₹${product.basePrice.toStringAsFixed(0)}',
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFF334155)),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'EMI starting @ ₹${product.emiPlans.isNotEmpty ? product.emiPlans.last.monthlyAmount.toStringAsFixed(0) : '0'}/mo',
                                  style: const TextStyle(color: Color(0xFF059669), fontSize: 12, fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                          const Icon(Icons.arrow_forward_ios, size: 14, color: Color(0xFF94A3B8)),
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
    );
  }
}