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

  @override
  void initState() {
    super.initState();
    if (widget.product.emiPlans.isNotEmpty) {
      _selectedPlan = widget.product.emiPlans.first;
    }
  }

  @override
  Widget build(BuildContext context) {
    final double finalPrice = widget.product.basePrice + widget.selectedVariant.priceExtra;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select EMI Plan', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.grey.shade50,
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(widget.product.imageUrl, width: 60, height: 60, fit: BoxFit.cover),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.product.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                      const SizedBox(height: 4),
                      Text(widget.selectedVariant.name, style: TextStyle(color: Colors.grey.shade600, fontSize: 13)),
                      const SizedBox(height: 4),
                      Text('Total: ₹${finalPrice.toStringAsFixed(0)}', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.deepPurple)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: widget.product.emiPlans.length,
              itemBuilder: (context, index) {
                final plan = widget.product.emiPlans[index];
                final isSelected = _selectedPlan == plan;

                return GestureDetector(
                  onTap: () => setState(() => _selectedPlan = plan),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.deepPurple.shade50 : Colors.white,
                      border: Border.all(
                        color: isSelected ? Colors.deepPurple : Colors.grey.shade300,
                        width: isSelected ? 2 : 1,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text('${plan.months} Months EMI', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                if (plan.isPopular) ...[
                                  const SizedBox(width: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                    decoration: BoxDecoration(color: Colors.orange.shade100, borderRadius: BorderRadius.circular(4)),
                                    child: const Text('Popular', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.orange)),
                                  ),
                                ],
                              ],
                            ),
                            const SizedBox(height: 6),
                            Text('Interest: ${plan.interestRate == 0 ? 'No Cost EMI' : '${plan.interestRate}% p.a.'}', style: TextStyle(color: Colors.grey.shade700, fontSize: 13)),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('₹${plan.monthlyAmount.toStringAsFixed(0)}/mo', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.deepPurple)),
                            const SizedBox(height: 4),
                            Radio<EMIPlan>(
                              value: plan,
                              groupValue: _selectedPlan,
                              activeColor: Colors.deepPurple,
                              onChanged: (val) => setState(() => _selectedPlan = val),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, -2))]),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: _selectedPlan == null ? null : () {
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: const Text('EMI Plan Confirmed!'),
                      content: Text('You have selected ${_selectedPlan!.months} Months EMI for ${widget.product.name}. Proceeding securely with 1Fi partner banks.'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(ctx);
                            Navigator.popUntil(context, (route) => route.isFirst);
                          },
                          child: const Text('Done', style: TextStyle(color: Colors.deepPurple)),
                        ),
                      ],
                    ),
                  );
                },
                child: const Text('Proceed with Selected EMI', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}