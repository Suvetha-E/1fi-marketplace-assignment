class UserProfile {
  final String id;
  final String fullName;
  final String phone;
  final double creditLimit;
  final double availableCredit;
  final int creditScore;
  final int rewardPoints;
  final String avatarUrl;

  UserProfile({
    required this.id,
    required this.fullName,
    required this.phone,
    required this.creditLimit,
    required this.availableCredit,
    required this.creditScore,
    required this.rewardPoints,
    required this.avatarUrl,
  });
}

class NotificationItem {
  final String id;
  final String title;
  final String message;
  final String timestamp;
  final bool isRead;

  NotificationItem({
    required this.id,
    required this.title,
    required this.message,
    required this.timestamp,
    this.isRead = false,
  });
}
