import 'package:flutter/material.dart';
import '../models/loan_model.dart';
import '../models/user_model.dart';

class CreditLimitCard extends StatelessWidget {
  final UserProfile user;
  final VoidCallback? onIncreaseLimitTap;

  const CreditLimitCard({
    super.key,
    required this.user,
    this.onIncreaseLimitTap,
  });

  @override
  Widget build(BuildContext context) {
    final usedCredit = user.creditLimit - user.availableCredit;
    final usedRatio = usedCredit / user.creditLimit;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF0F172A), Color(0xFF1E1B4B), Color(0xFF311042)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color(0x330F172A),
            blurRadius: 16,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: const Color(0xFF059669).withAlpha(50),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.verified_user_rounded, color: Color(0xFF10B981), size: 18),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    '1Fi Approved Credit Line',
                    style: TextStyle(color: Color(0xFF94A3B8), fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFD97706).withAlpha(40),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFF59E0B).withAlpha(100), width: 1),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.speed_rounded, color: Color(0xFFF59E0B), size: 13),
                    const SizedBox(width: 4),
                    Text(
                      'Score ${user.creditScore}',
                      style: const TextStyle(color: Color(0xFFFBBF24), fontSize: 11, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'Available Limit',
            style: TextStyle(color: Color(0xFFCBD5E1), fontSize: 12),
          ),
          const SizedBox(height: 4),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                '₹${user.availableCredit.toStringAsFixed(0)}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '/ Total ₹${(user.creditLimit / 100000).toStringAsFixed(1)}L',
                style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 13, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: user.availableCredit / user.creditLimit,
              backgroundColor: Colors.white.withAlpha(25),
              valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF10B981)),
              minHeight: 6,
            ),
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Used: ₹${usedCredit.toStringAsFixed(0)} (${(usedRatio * 100).toStringAsFixed(0)}%)',
                style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 11),
              ),
              GestureDetector(
                onTap: onIncreaseLimitTap,
                child: const Row(
                  children: [
                    Text(
                      'Increase Limit',
                      style: TextStyle(color: Color(0xFFA78BFA), fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 2),
                    Icon(Icons.arrow_forward_ios_rounded, color: Color(0xFFA78BFA), size: 10),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class QuickActionGrid extends StatelessWidget {
  final Function(String actionKey) onActionTap;

  const QuickActionGrid({super.key, required this.onActionTap});

  @override
  Widget build(BuildContext context) {
    final actions = [
      {'key': 'shop', 'label': 'Shop', 'icon': Icons.shopping_bag_rounded, 'color': const Color(0xFF6B21A8), 'badge': '0% EMI'},
      {'key': 'loan', 'label': 'Instant Loan', 'icon': Icons.bolt_rounded, 'color': const Color(0xFF0284C7), 'badge': 'Instant'},
      {'key': 'bills', 'label': 'Pay Bills', 'icon': Icons.receipt_long_rounded, 'color': const Color(0xFF059669), 'badge': null},
      {'key': 'score', 'label': 'Credit Score', 'icon': Icons.analytics_rounded, 'color': const Color(0xFFD97706), 'badge': 'Free'},
      {'key': 'rewards', 'label': '1Fi Rewards', 'icon': Icons.card_giftcard_rounded, 'color': const Color(0xFFE11D48), 'badge': '1,450 pts'},
    ];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: actions.map((item) {
          final color = item['color'] as Color;
          final icon = item['icon'] as IconData;
          final label = item['label'] as String;
          final key = item['key'] as String;
          final badge = item['badge'] as String?;

          return Expanded(
            child: GestureDetector(
              onTap: () => onActionTap(key),
              child: Column(
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          color: color.withAlpha(20),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: color.withAlpha(40), width: 1.5),
                        ),
                        child: Icon(icon, color: color, size: 24),
                      ),
                      if (badge != null)
                        Positioned(
                          top: -6,
                          right: -4,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                            decoration: BoxDecoration(
                              color: color,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              badge,
                              style: const TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    label,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF334155),
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class ActiveEmiCard extends StatelessWidget {
  final ActiveLoan loan;
  final VoidCallback onPayTap;

  const ActiveEmiCard({
    super.key,
    required this.loan,
    required this.onPayTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  loan.imageUrl,
                  width: 48,
                  height: 48,
                  fit: BoxFit.cover,
                  errorBuilder: (ctx, err, stack) => Container(
                    width: 48,
                    height: 48,
                    color: const Color(0xFFF1F5F9),
                    child: const Icon(Icons.devices, color: Color(0xFF64748B)),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      loan.productName,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFF0F172A)),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      loan.lenderPartner,
                      style: const TextStyle(color: Color(0xFF64748B), fontSize: 11),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFF3E8FF),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  '${loan.completedTenureMonths}/${loan.tenureMonths} EMIs Paid',
                  style: const TextStyle(color: Color(0xFF6B21A8), fontSize: 10, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(height: 1, color: Color(0xFFF1F5F9)),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Next Monthly EMI', style: TextStyle(color: Color(0xFF64748B), fontSize: 11)),
                  const SizedBox(height: 2),
                  Text(
                    '₹${loan.monthlyEmi.toStringAsFixed(0)}',
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF6B21A8)),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Due Date', style: TextStyle(color: Color(0xFF64748B), fontSize: 11)),
                  const SizedBox(height: 2),
                  Text(
                    loan.nextDueDate,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Color(0xFFDC2626)),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: onPayTap,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6B21A8),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  minimumSize: const Size(0, 36),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  elevation: 0,
                ),
                child: const Text('Pay EMI', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class PromoCarousel extends StatefulWidget {
  final Function(String promoTitle) onBannerTap;

  const PromoCarousel({super.key, required this.onBannerTap});

  @override
  State<PromoCarousel> createState() => _PromoCarouselState();
}

class _PromoCarouselState extends State<PromoCarousel> {
  final PageController _controller = PageController();
  int _currentIndex = 0;

  final promos = [
    {
      'title': '0% Interest on Apple Products',
      'subtitle': 'Up to 24 Months No-Cost EMI with 1Fi Credit Card',
      'tag': 'EXCLUSIVE',
      'colors': [const Color(0xFF1E1B4B), const Color(0xFF4C1D95)],
    },
    {
      'title': 'Instant ₹50,000 Credit Top-Up',
      'subtitle': 'Check eligibility in 30 seconds with instant approval',
      'tag': 'PRE-APPROVED',
      'colors': [const Color(0xFF064E3B), const Color(0xFF047857)],
    },
    {
      'title': 'Double 1Fi Reward Points',
      'subtitle': 'Earn 2x rewards on electronics purchased this week',
      'tag': 'REWARDS FEST',
      'colors': [const Color(0xFF701A75), const Color(0xFFBE185D)],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 130,
          child: PageView.builder(
            controller: _controller,
            onPageChanged: (idx) => setState(() => _currentIndex = idx),
            itemCount: promos.length,
            itemBuilder: (context, index) {
              final promo = promos[index];
              final colors = promo['colors'] as List<Color>;

              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: colors,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(40),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        promo['tag'] as String,
                        style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      promo['title'] as String,
                      style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      promo['subtitle'] as String,
                      style: TextStyle(color: Colors.white.withAlpha(200), fontSize: 11),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            promos.length,
            (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 3),
              width: _currentIndex == index ? 18 : 6,
              height: 6,
              decoration: BoxDecoration(
                color: _currentIndex == index ? const Color(0xFF6B21A8) : const Color(0xFFCBD5E1),
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
