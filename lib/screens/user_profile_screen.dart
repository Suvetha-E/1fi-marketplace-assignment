import 'package:flutter/material.dart';
import '../models/loan_model.dart';
import '../models/order_model.dart';
import '../models/user_model.dart';
import '../repositories/user_repository.dart';
import '../widgets/state_views.dart';
import 'auth_screen.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final UserRepository _userRepository = UserRepository();

  late Future<UserProfile> _userFuture;
  late Future<List<UserOrder>> _ordersFuture;
  late Future<List<ActiveLoan>> _loansFuture;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadProfileData();
  }

  void _loadProfileData() {
    setState(() {
      _userFuture = _userRepository.fetchUserProfile();
      _ordersFuture = _userRepository.fetchUserOrders();
      _loansFuture = _userRepository.fetchActiveLoans();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('My 1Fi Profile & Activity', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Color(0xFF0F172A))),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout_rounded, color: Color(0xFFDC2626)),
            onPressed: () {
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text('Logout from 1Fi?'),
                  content: const Text('Are you sure you want to sign out of your 1Fi FinTech account?'),
                  actions: [
                    TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => const AuthScreen()),
                          (route) => false,
                        );
                      },
                      child: const Text('Logout', style: TextStyle(color: Color(0xFFDC2626), fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<UserProfile>(
        future: _userFuture,
        builder: (context, userSnap) {
          if (userSnap.connectionState == ConnectionState.waiting) {
            return const LoadingView(message: 'Loading user activity...');
          } else if (userSnap.hasError || !userSnap.hasData) {
            return ErrorView(message: 'Failed to load user profile.', onRetry: _loadProfileData);
          }

          final user = userSnap.data!;
          return Column(
            children: [
              // User Header Card
              Container(
                color: Colors.white,
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 32,
                      backgroundColor: const Color(0xFF6B21A8),
                      child: Text(
                        user.fullName.substring(0, 1),
                        style: const TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user.fullName,
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
                          ),
                          const SizedBox(height: 2),
                          Text(user.phone, style: const TextStyle(color: Color(0xFF64748B), fontSize: 13)),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFEF3C7),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  'Score ${user.creditScore} • Excellent',
                                  style: const TextStyle(color: Color(0xFFD97706), fontSize: 10, fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF3E8FF),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  '${user.rewardPoints} 1Fi Pts',
                                  style: const TextStyle(color: Color(0xFF6B21A8), fontSize: 10, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Tab Bar Headers
              Container(
                color: Colors.white,
                child: TabBar(
                  controller: _tabController,
                  labelColor: const Color(0xFF6B21A8),
                  unselectedLabelColor: const Color(0xFF64748B),
                  indicatorColor: const Color(0xFF6B21A8),
                  indicatorWeight: 3,
                  labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                  tabs: const [
                    Tab(text: 'Orders & Booked'),
                    Tab(text: 'EMI History'),
                    Tab(text: 'Support & FAQs'),
                  ],
                ),
              ),

              const Divider(height: 1, color: Color(0xFFE2E8F0)),

              // Tab Bar Views
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    // Tab 1: Orders
                    FutureBuilder<List<UserOrder>>(
                      future: _ordersFuture,
                      builder: (context, snap) {
                        if (snap.connectionState == ConnectionState.waiting) return const LoadingView();
                        if (!snap.hasData || snap.data!.isEmpty) return const EmptyView(title: 'No past orders');

                        final orders = snap.data!;
                        return ListView.builder(
                          padding: const EdgeInsets.all(16),
                          itemCount: orders.length,
                          itemBuilder: (context, index) {
                            final ord = orders[index];
                            return Container(
                              margin: const EdgeInsets.only(bottom: 12),
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: const Color(0xFFE2E8F0)),
                              ),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(ord.imageUrl, width: 56, height: 56, fit: BoxFit.cover),
                                  ),
                                  const SizedBox(width: 14),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(ord.productName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFF0F172A))),
                                        const SizedBox(height: 2),
                                        Text('${ord.variantName} • ${ord.orderDate}', style: const TextStyle(color: Color(0xFF64748B), fontSize: 11)),
                                        const SizedBox(height: 4),
                                        Text('₹${ord.totalPrice.toStringAsFixed(0)} (${ord.emiMonths}m EMI)', style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF6B21A8), fontSize: 12)),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: ord.status == 'Delivered' ? const Color(0xFFD1FAE5) : const Color(0xFFE0F2FE),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      ord.status,
                                      style: TextStyle(
                                        color: ord.status == 'Delivered' ? const Color(0xFF059669) : const Color(0xFF0284C7),
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),

                    // Tab 2: EMI History
                    FutureBuilder<List<ActiveLoan>>(
                      future: _loansFuture,
                      builder: (context, snap) {
                        if (snap.connectionState == ConnectionState.waiting) return const LoadingView();
                        if (!snap.hasData || snap.data!.isEmpty) return const EmptyView(title: 'No active EMI history');

                        final loans = snap.data!;
                        return ListView.builder(
                          padding: const EdgeInsets.all(16),
                          itemCount: loans.length,
                          itemBuilder: (context, index) {
                            final loan = loans[index];
                            return Container(
                              margin: const EdgeInsets.only(bottom: 12),
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: const Color(0xFFE2E8F0)),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(loan.productName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFF0F172A))),
                                      Text('₹${loan.monthlyEmi.toStringAsFixed(0)}/mo', style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF6B21A8), fontSize: 14)),
                                    ],
                                  ),
                                  const SizedBox(height: 6),
                                  Text('Lender: ${loan.lenderPartner}', style: const TextStyle(color: Color(0xFF64748B), fontSize: 11)),
                                  const SizedBox(height: 10),
                                  LinearProgressIndicator(
                                    value: loan.progressRatio,
                                    backgroundColor: const Color(0xFFF1F5F9),
                                    color: const Color(0xFF059669),
                                    minHeight: 6,
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Paid: ${loan.completedTenureMonths}/${loan.tenureMonths} EMIs', style: const TextStyle(color: Color(0xFF64748B), fontSize: 11)),
                                      Text('Remaining: ₹${loan.remainingBalance.toStringAsFixed(0)}', style: const TextStyle(color: Color(0xFF334155), fontSize: 11, fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),

                    // Tab 3: Support & FAQs
                    ListView(
                      padding: const EdgeInsets.all(16),
                      children: const [
                        ExpansionTile(
                          title: Text('How does 1Fi No-Cost EMI work?', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                          children: [
                            Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Text('No-Cost EMI means you only pay the exact purchase price of the product divided by the EMI tenure with zero interest or processing fee.', style: TextStyle(color: Color(0xFF64748B), fontSize: 12, height: 1.4)),
                            ),
                          ],
                        ),
                        ExpansionTile(
                          title: Text('How to increase my 1Fi Credit Limit?', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                          children: [
                            Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Text('Maintain timely EMI payments and complete your KYC verification to qualify for automatic credit limit upgrades up to ₹5.0 Lakhs.', style: TextStyle(color: Color(0xFF64748B), fontSize: 12, height: 1.4)),
                            ),
                          ],
                        ),
                        ExpansionTile(
                          title: Text('What happens if I miss an EMI payment date?', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                          children: [
                            Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Text('Late payments incur a nominal bank fee and may negatively impact your 1Fi Credit Score. We recommend enabling Auto-Pay.', style: TextStyle(color: Color(0xFF64748B), fontSize: 12, height: 1.4)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
