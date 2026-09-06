class UserOrder {
  final String id;
  final String productName;
  final String imageUrl;
  final String variantName;
  final double totalPrice;
  final int emiMonths;
  final double monthlyAmount;
  final String orderDate;
  final String status; // e.g. 'Active EMI', 'Delivered', 'Processing'

  UserOrder({
    required this.id,
    required this.productName,
    required this.imageUrl,
    required this.variantName,
    required this.totalPrice,
    required this.emiMonths,
    required this.monthlyAmount,
    required this.orderDate,
    required this.status,
  });
}
