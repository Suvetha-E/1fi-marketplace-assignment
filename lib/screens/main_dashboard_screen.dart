import 'package:flutter/material.dart';
import '../models/loan_model.dart';
import '../models/user_model.dart';
import '../repositories/user_repository.dart';
import '../widgets/fintech_widgets.dart';
import '../widgets/state_views.dart';
import 'marketplace_home_screen.dart';
import 'shop_page.dart';
import 'user_profile_screen.dart';

class MainDashboardScreen extends StatefulWidget {
  const MainDashboardScreen({super.key});

  @override
  State<MainDashboardScreen> createState() => _MainDashboardScreenState();
}

class _MainDashboardScreenState extends State<MainDashboardScreen> {
  int _currentBottomNavIndex = 0;

  final UserRepository _userRepository = UserRepository();
  late Future<UserProfile> _userFuture;
  late Future<List<ActiveLoan>> _loansFuture;
  late Future<List<NotificationItem>> _notifsFuture;

  @override
  void initState() {
    super.initState();
    _loadDashboardData();
  }

  void _loadDashboardData() {
    setState(() {
      _userFuture = _userRepository.fetchUserProfile();
      _loansFuture = _userRepository.fetchActiveLoans();
      _notifsFuture = _userRepository.fetchNotifications();
    });
  }

  void _handleQuickAction(String key) {
    if (key == 'shop') {
      setState(() => _currentBottomNavIndex = 1);
    } else if (key == 'score' || key == 'rewards') {
      setState(() => _currentBottomNavIndex = 3);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Opening 1Fi ${key.toUpperCase()} service...'),
          backgroundColor: const Color(0xFF6B21A8),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  void _showNotificationsDialog(List<NotificationItem> notifications) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Notifications', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
                IconButton(onPressed: () => Navigator.pop(ctx), icon: const Icon(Icons.close)),
              ],
            ),
            const SizedBox(height: 12),
            ...notifications.map((item) => Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: item.isRead ? Colors.white : const Color(0xFFF3E8FF),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Row(
                children: [
                  Icon(
                    item.title.contains('Due') ? Icons.alarm_rounded : Icons.card_giftcard_rounded,
                    color: const Color(0xFF6B21A8),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                        const SizedBox(height: 2),
                        Text(item.message, style: const TextStyle(fontSize: 11, color: Color(0xFF64748B))),
                      ],
                    ),
                  ),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildHomeContent() {
    return FutureBuilder<UserProfile>(
      future: _userFuture,
      builder: (context, userSnapshot) {
        if (userSnapshot.connectionState == ConnectionState.waiting) {
          return const LoadingView(message: 'Loading your 1Fi Dashboard...');
        } else if (userSnapshot.hasError) {
          return ErrorView(
            message: 'Failed to load user profile. Check connection.',
            onRetry: _loadDashboardData,
          );
        } else if (!userSnapshot.hasData) {
          return const EmptyView(title: 'No User Profile Available');
        }

        final user = userSnapshot.data!;

        return RefreshIndicator(
          onRefresh: () async => _loadDashboardData(),
          color: const Color(0xFF6B21A8),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Custom Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: const Color(0xFF6B21A8),
                          child: Text(
                            user.fullName.substring(0, 1),
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hello, ${user.fullName.split(' ')[0]} 👋',
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
                            ),
                            const Text(
                              'Member Tier: 1Fi Prime',
                              style: TextStyle(fontSize: 11, color: Color(0xFF64748B), fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ],
                    ),
                    FutureBuilder<List<NotificationItem>>(
                      future: _notifsFuture,
                      builder: (context, notifSnap) {
                        final count = notifSnap.hasData ? notifSnap.data!.where((n) => !n.isRead).length : 0;
                        return Stack(
                          children: [
                            IconButton(
                              onPressed: () {
                                if (notifSnap.hasData) {
                                  _showNotificationsDialog(notifSnap.data!);
                                }
                              },
                              icon: const Icon(Icons.notifications_none_rounded, color: Color(0xFF0F172A), size: 26),
                            ),
                            if (count > 0)
                              Positioned(
                                right: 10,
                                top: 10,
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFDC2626),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Text(
                                    '$count',
                                    style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                          ],
                        );
                      },
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Credit Limit Banner Card
                CreditLimitCard(
                  user: user,
                  onIncreaseLimitTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Checking eligibility for Credit Limit enhancement...'),
                        backgroundColor: Color(0xFF6B21A8),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 20),

                // Quick Action Grid
                const Text(
                  'Quick Financial Actions',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFF0F172A)),
                ),
                const SizedBox(height: 12),
                QuickActionGrid(onActionTap: _handleQuickAction),

                const SizedBox(height: 20),

                // Active Loan / EMI Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Active Loans & EMI Schedule',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFF0F172A)),
                    ),
                    TextButton(
                      onPressed: () => setState(() => _currentBottomNavIndex = 3),
                      child: const Text(
                        'View All',
                        style: TextStyle(color: Color(0xFF6B21A8), fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                FutureBuilder<List<ActiveLoan>>(
                  future: _loansFuture,
                  builder: (context, loanSnap) {
                    if (loanSnap.connectionState == ConnectionState.waiting) {
                      return const SizedBox(
                        height: 100,
                        child: Center(child: CircularProgressIndicator(color: Color(0xFF6B21A8))),
                      );
                    } else if (loanSnap.hasError || !loanSnap.hasData || loanSnap.data!.isEmpty) {
                      return Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8FAFC),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                        ),
                        child: const Text('No active loans right now.', style: TextStyle(color: Color(0xFF64748B))),
                      );
                    }

                    final loans = loanSnap.data!;
                    return Column(
                      children: loans.map((loan) => ActiveEmiCard(
                        loan: loan,
                        onPayTap: () {
                          showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              title: const Text('Pay Monthly EMI'),
                              content: Text('Proceed to pay ₹${loan.monthlyEmi.toStringAsFixed(0)} for ${loan.productName} via 1Fi UPI / NetBanking?'),
                              actions: [
                                TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF6B21A8)),
                                  onPressed: () {
                                    Navigator.pop(ctx);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('EMI Repayment Successful!'),
                                        backgroundColor: Color(0xFF059669),
                                      ),
                                    );
                                  },
                                  child: const Text('Pay Now', style: TextStyle(color: Colors.white)),
                                ),
                              ],
                            ),
                          );
                        },
                      )).toList(),
                    );
                  },
                ),

                const SizedBox(height: 20),

                // Promotional Banners Carousel
                const Text(
                  '1Fi Featured Campaigns',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFF0F172A)),
                ),
                const SizedBox(height: 12),
                PromoCarousel(
                  onBannerTap: (title) {
                    setState(() => _currentBottomNavIndex = 1);
                  },
                ),

                const SizedBox(height: 24),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      _buildHomeContent(),
      const ShopPage(),
      const MarketplaceHomeScreen(),
      const UserProfileScreen(),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: IndexedStack(
          index: _currentBottomNavIndex,
          children: pages,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentBottomNavIndex,
        onTap: (index) => setState(() => _currentBottomNavIndex = index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF6B21A8),
        unselectedItemColor: const Color(0xFF94A3B8),
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 11),
        elevation: 8,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.storefront_rounded), label: 'Shop'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_bag_rounded), label: '1Fi Marketplace'),
          BottomNavigationBarItem(icon: Icon(Icons.person_rounded), label: 'Profile'),
        ],
      ),
    );
  }
}
