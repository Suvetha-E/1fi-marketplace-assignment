import 'package:flutter/material.dart';
import '../models/product_model.dart';

class EmiSelectionScreen extends StatefulWidget {
  final Product product;
  final ProductVariant selectedVariant;

  const EmiSelectionScreen({
    super.key,
    required this.product,
    required this.selectedVariant,
  });

  @override
  State<EmiSelectionScreen> createState() => _EmiSelectionScreenState();
}

class _EmiSelectionScreenState extends State<EmiSelectionScreen> {
  EMIPlan? _selectedPlan;
  double _downPayment = 0.0;
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    if (widget.product.emiPlans.isNotEmpty) {
      _selectedPlan = widget.product.emiPlans.first;
    }
  }

  void _confirmEmiBooking() {
    setState(() => _isProcessing = true);

    Future.delayed(const Duration(milliseconds: 1000), () {
      if (!mounted) return;
      setState(() => _isProcessing = false);

      showModalBottomSheet(
        context: context,
        isDismissible: false,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        builder: (ctx) => SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(18),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: const BoxDecoration(
                    color: Color(0xFFD1FAE5),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.check_circle_rounded, color: Color(0xFF059669), size: 36),
                ),
                const SizedBox(height: 12),
                const Text(
                  'EMI Plan Confirmed!',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
                ),
                const SizedBox(height: 6),
                Text(
                  'Your ${_selectedPlan!.months}-Month EMI plan of ₹${_selectedPlan!.monthlyAmount.toStringAsFixed(0)}/mo for ${widget.product.name} has been pre-approved.',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Color(0xFF64748B), fontSize: 12, height: 1.3),
                ),
                const SizedBox(height: 14),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Bank Lender Partner', style: TextStyle(color: Color(0xFF64748B), fontSize: 11)),
                      const Text('1Fi Credit / HDFC Bank', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Color(0xFF0F172A))),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: 44,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6B21A8),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      elevation: 0,
                    ),
                    onPressed: () {
                      Navigator.pop(ctx);
                      Navigator.popUntil(context, (route) => route.isFirst);
                    },
                    child: const Text('Back to 1Fi Dashboard', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final double finalPrice = widget.product.basePrice + widget.selectedVariant.priceExtra;
    final double netFinancedAmount = finalPrice - _downPayment;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text('Select EMI Plan', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Color(0xFF0F172A))),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Order Summary Bar
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    widget.product.imageUrl,
                    width: 56,
                    height: 56,
                    fit: BoxFit.cover,
                    errorBuilder: (ctx, err, stack) => Container(
                      width: 56,
                      height: 56,
                      color: const Color(0xFFF1F5F9),
                      child: const Icon(Icons.image_not_supported_rounded, color: Color(0xFF94A3B8)),
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.product.name,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFF0F172A)),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(widget.selectedVariant.name, style: const TextStyle(color: Color(0xFF64748B), fontSize: 12)),
                      const SizedBox(height: 2),
                      Text(
                        'Total Payable: ₹${finalPrice.toStringAsFixed(0)}',
                        style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF6B21A8), fontSize: 13),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: Color(0xFFE2E8F0)),

          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // Down Payment Option Selector
                const Text(
                  '1. Down Payment Selection',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFF0F172A)),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: ChoiceChip(
                        label: const Text('₹0 Down Payment'),
                        selected: _downPayment == 0.0,
                        onSelected: (val) => setState(() => _downPayment = 0.0),
                        selectedColor: const Color(0xFF6B21A8),
                        labelStyle: TextStyle(
                          color: _downPayment == 0.0 ? Colors.white : const Color(0xFF334155),
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                        showCheckmark: false,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ChoiceChip(
                        label: const Text('₹10,000 Down Payment'),
                        selected: _downPayment == 10000.0,
                        onSelected: (val) => setState(() => _downPayment = 10000.0),
                        selectedColor: const Color(0xFF6B21A8),
                        labelStyle: TextStyle(
                          color: _downPayment == 10000.0 ? Colors.white : const Color(0xFF334155),
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                        showCheckmark: false,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                const Text(
                  '2. Select Tenure Duration & Interest',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFF0F172A)),
                ),
                const SizedBox(height: 10),

                ...widget.product.emiPlans.map((plan) {
                  final isSelected = _selectedPlan == plan;

                  return GestureDetector(
                    onTap: () => setState(() => _selectedPlan = plan),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isSelected ? const Color(0xFFF3E8FF) : Colors.white,
                        border: Border.all(
                          color: isSelected ? const Color(0xFF6B21A8) : const Color(0xFFE2E8F0),
                          width: isSelected ? 2 : 1,
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    '${plan.months} Months EMI',
                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Color(0xFF0F172A)),
                                  ),
                                  if (plan.isNoCost) ...[
                                    const SizedBox(width: 8),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF059669),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: const Text('NO COST', style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: Colors.white)),
                                    ),
                                  ],
                                  if (plan.isPopular) ...[
                                    const SizedBox(width: 6),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFF59E0B),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: const Text('POPULAR', style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: Colors.white)),
                                    ),
                                  ],
                                ],
                              ),
                              const SizedBox(height: 6),
                              Text(
                                plan.interestRate == 0 ? '0% Interest • No hidden fees' : '${plan.interestRate}% p.a. standard bank interest',
                                style: const TextStyle(color: Color(0xFF64748B), fontSize: 12),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '₹${plan.monthlyAmount.toStringAsFixed(0)}/mo',
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF6B21A8)),
                              ),
                              const SizedBox(height: 4),
                              Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: isSelected ? const Color(0xFF6B21A8) : const Color(0xFF94A3B8),
                                    width: isSelected ? 6 : 2,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }),

                if (_selectedPlan != null) ...[
                  const SizedBox(height: 12),
                  // Breakdown card
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Loan Breakdown Summary', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Color(0xFF0F172A))),
                        const SizedBox(height: 8),
                        _buildRow('Financed Amount', '₹${netFinancedAmount.toStringAsFixed(0)}'),
                        _buildRow('Processing Fee', '₹0 (1Fi Special Waved)'),
                        _buildRow('Tenure', '${_selectedPlan!.months} Months'),
                        const Divider(height: 12),
                        _buildRow('Monthly EMI', '₹${_selectedPlan!.monthlyAmount.toStringAsFixed(0)}', isBold: true),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),

          // Sticky Confirm Bar
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(color: Color(0x14000000), blurRadius: 10, offset: Offset(0, -4))],
            ),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6B21A8),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 0,
                ),
                onPressed: (_selectedPlan == null || _isProcessing) ? null : _confirmEmiBooking,
                child: _isProcessing
                    ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                    : const Text('Confirm & Authorize EMI Plan', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRow(String title, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(color: Color(0xFF64748B), fontSize: 12)),
          Text(
            value,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
              fontSize: isBold ? 14 : 12,
              color: isBold ? const Color(0xFF6B21A8) : const Color(0xFF0F172A),
            ),
          ),
        ],
      ),
    );
  }
}