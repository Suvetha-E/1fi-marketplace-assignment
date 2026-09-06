import 'package:flutter/material.dart';
import '../models/product_model.dart';
import 'emi_selection_screen.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Product product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  late ProductVariant _selectedVariant;
  late String _selectedImageUrl;
  int _activeTab = 0; // 0 = Description, 1 = Specifications, 2 = 1Fi Benefits

  @override
  void initState() {
    super.initState();
    _selectedVariant = widget.product.variants.first;
    _selectedImageUrl = widget.product.imageUrl;
  }

  @override
  Widget build(BuildContext context) {
    final finalPrice = widget.product.basePrice + _selectedVariant.priceExtra;
    final gallery = widget.product.galleryImages.isNotEmpty
        ? widget.product.galleryImages
        : [widget.product.imageUrl];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.product.brand, style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF0F172A),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Product link copied to clipboard!')),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Main Product Image
            Container(
              height: 280,
              width: double.infinity,
              color: const Color(0xFFF8FAFC),
              child: Center(
                child: Image.network(
                  _selectedImageUrl,
                  fit: BoxFit.contain,
                  errorBuilder: (ctx, err, stack) => const Icon(Icons.image_not_supported_rounded, size: 64, color: Color(0xFF94A3B8)),
                ),
              ),
            ),

            // Gallery Thumbnails
            if (gallery.length > 1) ...[
              const SizedBox(height: 12),
              SizedBox(
                height: 60,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: gallery.length,
                  itemBuilder: (context, index) {
                    final img = gallery[index];
                    final isSelected = img == _selectedImageUrl;
                    return GestureDetector(
                      onTap: () => setState(() => _selectedImageUrl = img),
                      child: Container(
                        margin: const EdgeInsets.only(right: 8),
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: isSelected ? const Color(0xFF6B21A8) : const Color(0xFFE2E8F0),
                            width: isSelected ? 2 : 1,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(img, fit: BoxFit.cover),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category & Rating Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF3E8FF),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          widget.product.category.toUpperCase(),
                          style: const TextStyle(color: Color(0xFF6B21A8), fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star_rounded, size: 16, color: Color(0xFFF59E0B)),
                          const SizedBox(width: 4),
                          Text(
                            '${widget.product.rating} (${widget.product.reviewCount} Reviews)',
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Color(0xFF475569)),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.product.name,
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
                  ),
                  const SizedBox(height: 8),

                  // Pricing & EMI info
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        '₹${finalPrice.toStringAsFixed(0)}',
                        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF6B21A8)),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'MRP incl. of all taxes',
                        style: TextStyle(fontSize: 12, color: Color(0xFF64748B)),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Variant Selection Chips
                  const Text('Select Variant / Configuration', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFF0F172A))),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: widget.product.variants.map((variant) {
                      final isSelected = _selectedVariant == variant;
                      return ChoiceChip(
                        label: Text(variant.name),
                        selected: isSelected,
                        selectedColor: const Color(0xFF6B21A8),
                        backgroundColor: const Color(0xFFF1F5F9),
                        labelStyle: TextStyle(
                          color: isSelected ? Colors.white : const Color(0xFF334155),
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          fontSize: 12,
                        ),
                        onSelected: (selected) => setState(() => _selectedVariant = variant),
                        showCheckmark: false,
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 24),

                  // Tab headers (Description vs Specs)
                  Row(
                    children: [
                      _buildTabButton(0, 'Overview'),
                      const SizedBox(width: 12),
                      _buildTabButton(1, 'Specifications'),
                      const SizedBox(width: 12),
                      _buildTabButton(2, '1Fi Benefits'),
                    ],
                  ),
                  const SizedBox(height: 14),

                  // Tab Content
                  if (_activeTab == 0) ...[
                    Text(
                      widget.product.description,
                      style: const TextStyle(color: Color(0xFF475569), fontSize: 13, height: 1.5),
                    ),
                  ] else if (_activeTab == 1) ...[
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: Column(
                        children: widget.product.specs.entries.map((e) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 120,
                                  child: Text(e.key, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Color(0xFF64748B))),
                                ),
                                Expanded(
                                  child: Text(e.value, style: const TextStyle(fontSize: 12, color: Color(0xFF0F172A), fontWeight: FontWeight.w500)),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ] else ...[
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF3E8FF),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Column(
                        children: [
                          Row(
                            children: [
                              Icon(Icons.verified, color: Color(0xFF6B21A8), size: 18),
                              SizedBox(width: 8),
                              Text('100% Original Brand Warranty', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Color(0xFF6B21A8))),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(Icons.bolt, color: Color(0xFF6B21A8), size: 18),
                              SizedBox(width: 8),
                              Text('Zero Processing Fee for 1Fi Credit Users', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Color(0xFF6B21A8))),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],

                  const SizedBox(height: 24),

                  // EMI Highlight Banner Box
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF059669).withAlpha(15),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: const Color(0xFF059669).withAlpha(40)),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            color: Color(0xFF059669),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.flash_on_rounded, color: Colors.white, size: 20),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'No-Cost EMI Financing Available',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Color(0xFF065F46)),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'Starting @ ₹${widget.product.emiPlans.isNotEmpty ? widget.product.emiPlans.first.monthlyAmount.toStringAsFixed(0) : '0'}/month with 0% interest.',
                                style: const TextStyle(fontSize: 11, color: Color(0xFF047857)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Color(0x14000000), blurRadius: 10, offset: Offset(0, -4))],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Total Price', style: TextStyle(color: Color(0xFF64748B), fontSize: 11)),
                  Text(
                    '₹${finalPrice.toStringAsFixed(0)}',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
                  ),
                ],
              ),
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6B21A8),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 0,
              ),
              icon: const Icon(Icons.credit_score_rounded, size: 20),
              label: const Text('Select EMI Plan', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EmiSelectionScreen(
                      product: widget.product,
                      selectedVariant: _selectedVariant,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabButton(int index, String label) {
    final isSelected = _activeTab == index;
    return GestureDetector(
      onTap: () => setState(() => _activeTab = index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF0F172A) : const Color(0xFFF1F5F9),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : const Color(0xFF64748B),
            fontSize: 12,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}