import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NotificationsScreen extends StatefulWidget {
  final List notifications;

  const NotificationsScreen({super.key, required this.notifications});

  @override
  State createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _tabs = ['All', 'Subjects', 'Exams', 'Homework'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications', 
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Color(0xFF38D8A8),
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          indicatorColor: Colors.white,
          tabs: _tabs.map((tab) => Tab(text: tab)).toList(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildAllNotifications(),
          _buildSubjectNotifications(),
          _buildExamNotifications(),
          _buildHomeworkNotifications(),
        ],
      ),
    );
  }

  Widget _buildAllNotifications() {
    return Container(
      color: Color(0xFFF5FDF9),
      child: widget.notifications.isEmpty
          ? const Center(
              child: Text('No notifications',
                  style: TextStyle(color: Colors.black54, fontSize: 18)),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: widget.notifications.length,
              itemBuilder: (context, index) {
                final notification = widget.notifications[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (notification.isRead == false)
                          Container(
                            margin: const EdgeInsets.only(top: 6, right: 10),
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              color: Color(0xFF38D8A8),
                              shape: BoxShape.circle,
                            ),
                          ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                notification.title,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                notification.message,
                                style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                DateFormat('MMM d, yyyy - h:mm a')
                                    .format(notification.date),
                                style: TextStyle(
                                  color: Colors.grey[500],
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }

  Widget _buildSubjectNotifications() {
    List<Map<String, dynamic>> subjectNotifications = [
      {
        'title': 'New Math Assignment Posted',
        'subject': 'Mathematics',
        'message': 'Chapter 7 Algebra exercises have been assigned for next week.',
        'date': DateTime.now().subtract(const Duration(hours: 3)),
        'subjectColor': Colors.blue,
        'isRead': false,
      },
      {
        'title': 'Science Lab Group Assignment',
        'subject': 'Science',
        'message': 'Lab partners for the upcoming experiment have been posted.',
        'date': DateTime.now().subtract(const Duration(hours: 8)),
        'subjectColor': Colors.green,
        'isRead': true,
      },
      {
        'title': 'English Literature Discussion',
        'subject': 'English',
        'message': 'Please prepare chapters 5-7 of "To Kill a Mockingbird" for tomorrow\'s class discussion.',
        'date': DateTime.now().subtract(const Duration(days: 1)),
        'subjectColor': Colors.purple,
        'isRead': false,
      },
    ];

    return Container(
      color: Color(0xFFF5FDF9),
      child: subjectNotifications.isEmpty
          ? const Center(
              child: Text('No subject notifications',
                  style: TextStyle(color: Colors.black54, fontSize: 18)),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: subjectNotifications.length,
              itemBuilder: (context, index) {
                final notification = subjectNotifications[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (notification['isRead'] == false)
                          Container(
                            margin: const EdgeInsets.only(top: 6, right: 10),
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              color: Color(0xFF38D8A8),
                              shape: BoxShape.circle,
                            ),
                          ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: notification['subjectColor'].withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      notification['subject'],
                                      style: TextStyle(
                                        color: notification['subjectColor'],
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                notification['title'],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                notification['message'],
                                style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                DateFormat('MMM d, yyyy - h:mm a')
                                    .format(notification['date']),
                                style: TextStyle(
                                  color: Colors.grey[500],
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }

  Widget _buildExamNotifications() {
    List<Map<String, dynamic>> examNotifications = [
      {
        'title': 'Mid-Term Exam Schedule Posted',
        'subject': 'All Subjects',
        'message': 'Mid-term exams will be held from May 15-22. Check the detailed schedule.',
        'date': DateTime.now().subtract(const Duration(days: 2)),
        'examDate': 'May 15-22, 2025',
        'isRead': false,
      },
      {
        'title': 'Math Final Exam Update',
        'subject': 'Mathematics',
        'message': 'The final math exam will now include chapters 1-8 instead of 1-7.',
        'date': DateTime.now().subtract(const Duration(days: 1)),
        'examDate': 'June 5, 2025',
        'isRead': true,
      },
      {
        'title': 'Science Project Presentation',
        'subject': 'Science',
        'message': 'Final science project presentations will be held in the auditorium.',
        'date': DateTime.now().subtract(const Duration(hours: 12)),
        'examDate': 'May 28, 2025',
        'isRead': false,
      },
    ];

    return Container(
      color: Color(0xFFF5FDF9),
      child: examNotifications.isEmpty
          ? const Center(
              child: Text('No exam notifications',
                  style: TextStyle(color: Colors.black54, fontSize: 18)),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: examNotifications.length,
              itemBuilder: (context, index) {
                final notification = examNotifications[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (notification['isRead'] == false)
                          Container(
                            margin: const EdgeInsets.only(top: 6, right: 10),
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              color: Color(0xFF38D8A8),
                              shape: BoxShape.circle,
                            ),
                          ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                notification['title'],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                  color: Color(0xFFFFE8E8),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.calendar_today, size: 14, color: Colors.red[700]),
                                    const SizedBox(width: 4),
                                    Text(
                                      notification['examDate'],
                                      style: TextStyle(
                                        color: Colors.red[700],
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                notification['message'],
                                style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                DateFormat('MMM d, yyyy - h:mm a')
                                    .format(notification['date']),
                                style: TextStyle(
                                  color: Colors.grey[500],
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }

  Widget _buildHomeworkNotifications() {
    List<Map<String, dynamic>> homeworkNotifications = [
      {
        'title': 'Math Homework Due Tomorrow',
        'subject': 'Mathematics',
        'message': 'Complete exercises 5-12 from chapter 4 in your workbook.',
        'date': DateTime.now().subtract(const Duration(hours: 5)),
        'dueDate': 'Tomorrow, 9:00 AM',
        'isRead': false,
      },
      {
        'title': 'English Essay Submission',
        'subject': 'English',
        'message': 'Submit your comparative essay on themes in "The Great Gatsby".',
        'date': DateTime.now().subtract(const Duration(days: 1)),
        'dueDate': 'May 12, 2025, 5:00 PM',
        'isRead': true,
      },
      {
        'title': 'History Project Deadline Extended',
        'subject': 'History',
        'message': 'The deadline for the Renaissance period project has been extended by one week.',
        'date': DateTime.now().subtract(const Duration(hours: 20)),
        'dueDate': 'May 20, 2025, 11:59 PM',
        'isRead': false,
      },
    ];

    return Container(
      color: Color(0xFFF5FDF9),
      child: homeworkNotifications.isEmpty
          ? const Center(
              child: Text('No homework notifications',
                  style: TextStyle(color: Colors.black54, fontSize: 18)),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: homeworkNotifications.length,
              itemBuilder: (context, index) {
                final notification = homeworkNotifications[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (notification['isRead'] == false)
                          Container(
                            margin: const EdgeInsets.only(top: 6, right: 10),
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              color: Color(0xFF38D8A8),
                              shape: BoxShape.circle,
                            ),
                          ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: Color(0xFF38D8A8).withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      notification['subject'],
                                      style: TextStyle(
                                        color: Color(0xFF38D8A8),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                notification['title'],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                  color: Color(0xFFE5F6FF),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.access_time, size: 14, color: Colors.blue[700]),
                                    const SizedBox(width: 4),
                                    Text(
                                      'Due: ${notification['dueDate']}',
                                      style: TextStyle(
                                        color: Colors.blue[700],
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                notification['message'],
                                style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                DateFormat('MMM d, yyyy - h:mm a')
                                    .format(notification['date']),
                                style: TextStyle(
                                  color: Colors.grey[500],
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}