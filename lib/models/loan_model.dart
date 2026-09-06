class ActiveLoan {
  final String id;
  final String productName;
  final String imageUrl;
  final String lenderPartner;
  final double totalAmount;
  final double remainingBalance;
  final double monthlyEmi;
  final String nextDueDate;
  final int tenureMonths;
  final int completedTenureMonths;

  ActiveLoan({
    required this.id,
    required this.productName,
    required this.imageUrl,
    required this.lenderPartner,
    required this.totalAmount,
    required this.remainingBalance,
    required this.monthlyEmi,
    required this.nextDueDate,
    required this.tenureMonths,
    required this.completedTenureMonths,
  });

  double get progressRatio => completedTenureMonths / tenureMonths;
}
