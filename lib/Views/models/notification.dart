class NotificationItem {
  final String title;
  final String message;
  final DateTime date;
  bool isRead;

  NotificationItem({
    required this.title,
    required this.message,
    required this.date,
    this.isRead = false,
  });
}
