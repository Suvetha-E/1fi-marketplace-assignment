import '../models/user_model.dart';
import '../models/loan_model.dart';
import '../models/order_model.dart';

class UserRepository {
  Future<UserProfile> fetchUserProfile() async {
    await Future.delayed(const Duration(milliseconds: 600));
    return UserProfile(
      id: 'usr_101',
      fullName: 'Suvetha',
      phone: '+91 98765 43210',
      creditLimit: 250000.0,
      availableCredit: 185000.0,
      creditScore: 782,
      rewardPoints: 1450,
      avatarUrl: 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=200',
    );
  }

  Future<bool> verifyOtp(String phone, String otp) async {
    await Future.delayed(const Duration(milliseconds: 800));
    return otp == '123456' || otp.length == 6;
  }

  Future<List<ActiveLoan>> fetchActiveLoans() async {
    await Future.delayed(const Duration(milliseconds: 700));
    return [
      ActiveLoan(
        id: 'loan_1',
        productName: 'iPhone 15 Pro (256GB)',
        imageUrl: 'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=300',
        lenderPartner: '1Fi Credit Partners / HDFC Bank',
        totalAmount: 134900.0,
        remainingBalance: 45000.0,
        monthlyEmi: 11241.0,
        nextDueDate: '15th Oct 2026',
        tenureMonths: 12,
        completedTenureMonths: 8,
      ),
      ActiveLoan(
        id: 'loan_2',
        productName: 'Sony WH-1000XM5 Headphones',
        imageUrl: 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=300',
        lenderPartner: '1Fi Instant Pay / ICICI',
        totalAmount: 29990.0,
        remainingBalance: 9996.0,
        monthlyEmi: 4998.0,
        nextDueDate: '05th Oct 2026',
        tenureMonths: 6,
        completedTenureMonths: 4,
      ),
    ];
  }

  Future<List<UserOrder>> fetchUserOrders() async {
    await Future.delayed(const Duration(milliseconds: 600));
    return [
      UserOrder(
        id: 'ord_901',
        productName: 'MacBook Pro 16" M3 Max',
        imageUrl: 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=300',
        variantName: '512GB SSD / 16GB RAM',
        totalPrice: 249999.0,
        emiMonths: 6,
        monthlyAmount: 41666.0,
        orderDate: '28 Aug 2026',
        status: 'Delivered',
      ),
      UserOrder(
        id: 'ord_902',
        productName: 'Samsung Galaxy Watch 6',
        imageUrl: 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=300',
        variantName: 'LTE 44mm Graphite',
        totalPrice: 32999.0,
        emiMonths: 3,
        monthlyAmount: 10999.0,
        orderDate: '12 Sep 2026',
        status: 'In Transit',
      ),
    ];
  }

  Future<List<NotificationItem>> fetchNotifications() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return [
      NotificationItem(
        id: 'notif_1',
        title: 'EMI Due Reminder',
        message: 'Your monthly EMI of ₹11,241 for iPhone 15 Pro is due on 15th Oct.',
        timestamp: '2 hours ago',
      ),
      NotificationItem(
        id: 'notif_2',
        title: 'Credit Limit Increased!',
        message: 'Congratulations! Your pre-approved 1Fi credit limit is now ₹2.5 Lakhs.',
        timestamp: '1 day ago',
        isRead: true,
      ),
      NotificationItem(
        id: 'notif_3',
        title: 'Cashback Credited',
        message: '₹500 1Fi Rewards cashback credited to your wallet.',
        timestamp: '3 days ago',
        isRead: true,
      ),
    ];
  }
}
