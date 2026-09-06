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

  @override
  void initState() {
    super.initState();
    _selectedVariant = widget.product.variants.first;
  }

  @override
  Widget build(BuildContext context) {
    final finalPrice = widget.product.basePrice + _selectedVariant.priceExtra;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.category, style: const TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(widget.product.imageUrl, height: 280, width: double.infinity, fit: BoxFit.cover),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.product.name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text('₹${finalPrice.toStringAsFixed(0)}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.deepPurple)),
                  const SizedBox(height: 16),
                  const Text('Select Configuration / Variant', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: widget.product.variants.map((variant) {
                      final isSelected = _selectedVariant == variant;
                      return ChoiceChip(
                        label: Text(variant.name),
                        selected: isSelected,
                        selectedColor: Colors.deepPurple.shade100,
                        labelStyle: TextStyle(color: isSelected ? Colors.deepPurple.shade900 : Colors.black, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal),
                        onSelected: (selected) => setState(() => _selectedVariant = variant),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),
                  const Text('Description', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 8),
                  Text(widget.product.description, style: TextStyle(color: Colors.grey.shade700, height: 1.4)),
                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(color: Colors.deepPurple.shade50, borderRadius: BorderRadius.circular(12)),
                    child: Row(
                      children: [
                        const Icon(Icons.flash_on, color: Colors.deepPurple),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Easy EMI available starting @ ₹${widget.product.emiPlans.isNotEmpty ? widget.product.emiPlans.last.monthlyAmount.toStringAsFixed(0) : '0'}/mo',
                            style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.deepPurple),
                          ),
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
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4, offset: const Offset(0, -2))]),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
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
          child: const Text('Select EMI Plan', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}