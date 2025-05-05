
import 'package:corona_lms/views/models/notification.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class NotificationsScreen extends StatefulWidget {
  final List<NotificationItem> notifications;

  const NotificationsScreen({Key? key, required this.notifications})
      : super(key: key);

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Container(
        color: Colors.white,
        child: widget.notifications.isEmpty
            ? const Center(
                child: Text('No notifications',
                    style: TextStyle(color: Colors.black54, fontSize: 18)),
              )
            : ListView.builder(
                itemCount: widget.notifications.length,
                itemBuilder: (context, index) {
                  final notification = widget.notifications[index];
                  return Card(
                    margin:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16),
                      leading: Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: notification.isRead
                              ? Colors.transparent
                              : Colors.blue,
                          shape: BoxShape.circle,
                        ),
                      ),
                      title: Text(
                        notification.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 8),
                          Text(notification.message),
                          const SizedBox(height: 8),
                          Text(
                            DateFormat('MMM d, yyyy - h:mm a')
                                .format(notification.date),
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}