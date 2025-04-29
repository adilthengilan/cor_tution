import 'package:coaching_academy/views/classes.dart';
import 'package:coaching_academy/views/notificationsi.dart';
import 'package:coaching_academy/views/search.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'dart:io';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String userName = 'Jamsheer';
  String userRole = 'Student';
  File? _profileImage;
  final ImagePicker _picker = ImagePicker();

  // Pre-loaded asset image for profile (will be used if no image is picked)
  final String defaultProfileImage = 'asset/person.jpg';
  bool useAssetImage = true;

  // ScrollControllers for horizontal lists
  final ScrollController _courseScrollController = ScrollController();
  final ScrollController _recommendedScrollController = ScrollController();
  final ScrollController _eventsScrollController = ScrollController();

  // Sample notifications data
  final List<NotificationItem> _notifications = [
    NotificationItem(
      title: 'New Course Available',
      message: 'Check out our new Flutter development course',
      date: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    NotificationItem(
      title: 'Assignment Due',
      message: 'Your Python assignment is due tomorrow',
      date: DateTime.now().subtract(const Duration(hours: 8)),
    ),
    NotificationItem(
      title: 'Live Session',
      message: 'Join the live session on Data Structures at 7 PM',
      date: DateTime.now().subtract(const Duration(days: 1)),
      isRead: true,
    ),
    NotificationItem(
      title: 'Course Completed',
      message: 'Congratulations! You have completed the HTML course',
      date: DateTime.now().subtract(const Duration(days: 2)),
      isRead: true,
    ),
  ];

  // Sample upcoming events
  final List<Map<String, dynamic>> _upcomingEvents = [
    {
      'title': 'Web Dev Workshop',
      'date': DateTime.now().add(const Duration(days: 2)),
      'duration': '2 hours',
      'instructor': 'John Doe',
      'color': Colors.blue,
      'icon': Icons.web
    },
    {
      'title': 'Mobile App Hackathon',
      'date': DateTime.now().add(const Duration(days: 4)),
      'duration': '8 hours',
      'instructor': 'Jane Smith',
      'color': Colors.green,
      'icon': Icons.phone_android
    },
    {
      'title': 'Machine Learning Seminar',
      'date': DateTime.now().add(const Duration(days: 7)),
      'duration': '1.5 hours',
      'instructor': 'Dr. Michael Johnson',
      'color': Colors.purple,
      'icon': Icons.psychology
    },
  ];

  // Sample statistics data
  final Map<String, dynamic> _studyStats = {
    'hoursThisWeek': 12.5,
    'completedLessons': 28,
    'coursesInProgress': 3,
    'averageScore': 87,
  };

  // Variable to track if notification alert is visible
  bool _showNotificationAlert = true;
  int _unreadNotificationsCount = 0;

  @override
  void initState() {
    super.initState();
    // Calculate unread notifications count
    _unreadNotificationsCount = _notifications.where((n) => !n.isRead).length;
  }

  // Function to scroll any horizontal list to the left
  void _scrollLeft(ScrollController controller) {
    if (controller.hasClients) {
      final currentPosition = controller.offset;
      final scrollAmount = currentPosition - 200.0;
      controller.animateTo(
        scrollAmount < 0 ? 0 : scrollAmount,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  // Function to scroll any horizontal list to the right
  void _scrollRight(ScrollController controller) {
    if (controller.hasClients) {
      final currentPosition = controller.offset;
      final scrollAmount = currentPosition + 200.0;
      controller.animateTo(
        scrollAmount,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  // Function to pick image from gallery or camera
  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
        useAssetImage = false;
      });
    }
  }

  // Function to show profile editing dialog
  void _showProfileEditDialog() {
    final TextEditingController nameController =
        TextEditingController(text: userName);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        title:
            const Text('Edit Profile', style: TextStyle(color: Colors.black)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
                labelStyle: TextStyle(color: Colors.black54),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black26),
                ),
              ),
              style: const TextStyle(color: Colors.black),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => _pickImage(ImageSource.camera),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Camera'),
                ),
                ElevatedButton(
                  onPressed: () => _pickImage(ImageSource.gallery),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Gallery'),
                ),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: Colors.blue)),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                userName = nameController.text;
              });
              Navigator.pop(context);
            },
            child: const Text('Save', style: TextStyle(color: Colors.blue)),
          ),
        ],
      ),
    );
  }

  // Function to dismiss notification alert
  void _dismissNotificationAlert() {
    setState(() {
      _showNotificationAlert = false;
    });
  }

  // Function to navigate to notifications screen
  void _navigateToNotifications() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            NotificationsScreen(notifications: _notifications),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Container(
        color: Colors.white,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              GestureDetector(
                                onTap: _showProfileEditDialog,
                                child: Container(
                                  width: 45,
                                  height: 45,
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        spreadRadius: 1,
                                        blurRadius: 3,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                    image: useAssetImage
                                        ? const DecorationImage(
                                            image:
                                                AssetImage('asset/person.jpg'),
                                            fit: BoxFit.cover,
                                          )
                                        : _profileImage != null
                                            ? DecorationImage(
                                                image:
                                                    FileImage(_profileImage!),
                                                fit: BoxFit.cover,
                                              )
                                            : null,
                                  ),
                                  child:
                                      (!useAssetImage && _profileImage == null)
                                          ? const Icon(Icons.person,
                                              color: Colors.white)
                                          : null,
                                ),
                              ),
                              const SizedBox(width: 10),
                              GestureDetector(
                                onTap: _showProfileEditDialog,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      userName,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      userRole,
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: IconButton(
                                  icon: const Icon(Icons.search,
                                      color: Colors.black),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const SearchScreen()));
                                  },
                                ),
                              ),
                              const SizedBox(width: 10),
                              Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: IconButton(
                                      icon: const Icon(
                                          Icons.notifications_outlined,
                                          color: Colors.black),
                                      onPressed: _navigateToNotifications,
                                    ),
                                  ),
                                  if (_unreadNotificationsCount > 0)
                                    Positioned(
                                      right: 0,
                                      top: 0,
                                      child: Container(
                                        padding: const EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              color: Colors.white, width: 1.5),
                                        ),
                                        constraints: const BoxConstraints(
                                          minWidth: 16,
                                          minHeight: 16,
                                        ),
                                        child: Text(
                                          _unreadNotificationsCount.toString(),
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Welcome Message
                SliverToBoxAdapter(
                  child: Container(
                    margin: const EdgeInsets.only(top: 30),
                    child: Text(
                      'Welcome back, $userName!',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ),

                // Notification Alert Container
                if (_showNotificationAlert && _unreadNotificationsCount > 0)
                  SliverToBoxAdapter(
                    child: Container(
                      margin: const EdgeInsets.only(top: 20),
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.blue.withOpacity(0.3)),
                      ),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(Icons.notifications_active,
                                  color: Colors.blue, size: 22),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'You have $_unreadNotificationsCount new notifications',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Latest: ${_notifications.where((n) => !n.isRead).first.title}',
                                      style: TextStyle(
                                        color: Colors.grey[700],
                                        fontSize: 13,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      DateFormat('MMM d, yyyy - h:mm a').format(
                                          _notifications
                                              .where((n) => !n.isRead)
                                              .first
                                              .date),
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.close, size: 16),
                                onPressed: _dismissNotificationAlert,
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                                color: Colors.grey[700],
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: _navigateToNotifications,
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.blue,
                                  backgroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 8),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: const Text('View All'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                // Study Statistics
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 30),
                      const Text(
                        'Your Progress',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.blue.withOpacity(0.2)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildStatItem(
                              "${_studyStats['hoursThisWeek']}h",
                              'This Week',
                              Icons.access_time,
                            ),
                            _buildStatItem(
                              "${_studyStats['completedLessons']}",
                              'Lessons Done',
                              Icons.check_circle_outline,
                            ),
                            _buildStatItem(
                              "${_studyStats['averageScore']}%",
                              'Score',
                              Icons.star_outline,
                            ),
                            _buildStatItem(
                              "${_studyStats['coursesInProgress']}",
                              'Courses',
                              Icons.menu_book_outlined,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // New courses section
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'New courses',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.arrow_back_ios,
                                      color: Colors.black, size: 18),
                                  onPressed: () => _scrollLeft(_courseScrollController),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.arrow_forward_ios,
                                      color: Colors.black, size: 18),
                                  onPressed: () => _scrollRight(_courseScrollController),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),

                // New courses list
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 140,
                    child: ListView(
                      controller: _courseScrollController,
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      children: [
                        _buildCourseCard(
                            'Design', '17 courses', 'asset/design.jpg'),
                        _buildCourseCard(
                            'Programming', '8 courses', 'asset/program.jpg'),
                        _buildCourseCard(
                            'Language', '12 courses', 'asset/languages.jpg'),
                        _buildCourseCard('Digital Marketing', '9 courses',
                            'asset/digitalmarketing.jpg'),
                        _buildCourseCard('Photography', '6 courses',
                            'asset/photography.jpg'),
                      ],
                    ),
                  ),
                ),

                // Continue learning section
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 30),
                      const Text(
                        'Continue learning',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
  SliverList(
                  delegate: SliverChildListDelegate([
                    _buildLessonCard(
                      'Python for beginners',
                      '12 lessons',
                      0.72, // 72% complete
                      Colors.blue,
                      Icons.code, // Using an icon instead of image path
                      'asset/python.jpg', // Added asset path parameter
                    ),
                    _buildLessonCard(
                      'HTML 5',
                      '17 lessons',
                      0.58, // 58% complete
                      Colors.orange,
                      Icons.html, // Using an icon instead of image path
                      'asset/html.webp', // Added asset path parameter
                    ),
                    _buildLessonCard(
                      'C++ Backend',
                      '8 lessons',
                      0.47, // 47% complete
                      Colors.blue,
                      Icons
                          .code_outlined, // Using an icon instead of image path
                      'asset/c++.jpg', // Added asset path parameter
                    ),
                    _buildLessonCard(
                      'Basic CSS',
                      '10 lessons',
                      0.0, // 0% complete
                      Colors.blue,
                      Icons.css, // Using an icon instead of image path
                      'asset/css.jpg', // Added asset path parameter
                    ),
                    _buildLessonCard(
                      'Basic Java Script',
                      '10 lessons',
                      0.0, // 0% complete
                      Colors.blue,
                      Icons.javascript, // Using an icon instead of image path
                      'asset/java.png', // Added asset path parameter
                    ),
                    _buildLessonCard(
                      'Basic Ui&Ux',
                      '10 lessons',
                      0.0, // 0% complete
                      Colors.blue,
                      Icons
                          .design_services, // Using an icon instead of image path
                      'asset/uiux.png', // Added asset path parameter
                    ),
                  ]),
                ),

                // Recommended for you section
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Recommended for you',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.arrow_back_ios,
                                      color: Colors.black, size: 18),
                                  onPressed: () => _scrollLeft(_recommendedScrollController),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.arrow_forward_ios,
                                      color: Colors.black, size: 18),
                                  onPressed: () => _scrollRight(_recommendedScrollController),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),

                // Recommended courses list
                // SliverToBoxAdapter(
                //   child: SizedBox(
                //     height: 220,
                //     child: ListView(
                //       controller: _recommendedScrollController,
                //       scrollDirection: Axis.horizontal,
                //       physics: const BouncingScrollPhysics(),
                //       children: [
                //         _buildRecommendedCourseCard(
                //           'Flutter Mobile Development',
                //           '24 lessons • 4.8 ★',
                //           'John Smith',
                //           'Based on your interest in programming',
                //           Colors.blue.shade50,
                //           Icons.phone_android,
                //           'asset/flutter.jpg',
                //         ),
                //         _buildRecommendedCourseCard(
                //           'React Web Development',
                //           '32 lessons • 4.7 ★',
                //           'Sarah Johnson',
                //           'Popular in your category',
                //           Colors.green.shade50,
                //           Icons.web,
                //           'asset/react.jpg',
                //         ),
                //         _buildRecommendedCourseCard(
                //           'Data Science Fundamentals',
                //           '40 lessons • 4.9 ★',
                //           'Dr. Alex Chen',
                //           'New & trending',
                //           Colors.purple.shade50,
                //           Icons.analytics_outlined,
                //           'asset/datascience.jpg',
                //         ),
                //       ],
                //     ),
                //   ),
                // ),

                // Upcoming events section
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Upcoming events',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.arrow_back_ios,
                                      color: Colors.black, size: 18),
                                  onPressed: () => _scrollLeft(_eventsScrollController),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.arrow_forward_ios,
                                      color: Colors.black, size: 18),
                                  onPressed: () => _scrollRight(_eventsScrollController),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),

                // Events list
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 180,
                    child: ListView.builder(
                      controller: _eventsScrollController,
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemCount: _upcomingEvents.length,
                      itemBuilder: (context, index) {
                        final event = _upcomingEvents[index];
                        // return _buildEventCard(
                        //   event['title'],
                        //   event['date'],
                        //   event['duration'],
                        //   event['instructor'],
                        //   event['color'],
                        //   event['icon'],
                        // );
                      },
                    ),
                  ),
                ),

                // Join community section
                SliverToBoxAdapter(
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 30),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.blue.shade400, Colors.blue.shade700],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Join our community',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'Connect with other students and share your learning journey',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.9),
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 15),
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.blue,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 10,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: const Text('Join Now'),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Icon(
                          Icons.groups_outlined,
                          color: Colors.white,
                          size: 60,
                        ),
                      ],
                    ),
                  ),
                ),

                // Bottom padding
                const SliverToBoxAdapter(
                  child: SizedBox(height: 20),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget to build statistics item
  Widget _buildStatItem(String value, String label, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Colors.blue, size: 24),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.black87,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

   // Updated course card for white theme
  Widget _buildCourseCard(String title, String subtitle, String imagePath) {
    return GestureDetector(
      onTap: () {
        // Navigate to course details when a course card is tapped
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const CoursesScreen(),
          ),
        );
      },
      child: Container(
        width: 160,
        margin: const EdgeInsets.only(right: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
          ),
        ),
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 5),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                subtitle,
                style: const TextStyle(
                  color: Colors.black54,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Updated lesson card for white theme
  Widget _buildLessonCard(String title, String lessons, double progress,
      Color iconColor, IconData iconData, String assetPath) {
    return GestureDetector(
      onTap: () {
        // Navigate to lesson details when a lesson card is tapped
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const CoursesScreen(),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.05),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: const Offset(0, 2),
                  ),
                ],
                image: DecorationImage(
                  image: AssetImage(assetPath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        lessons,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '${(progress * 100).toInt()}% complete',
                        style: TextStyle(
                          color: progress > 0 ? Colors.blue : Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: progress,
                      backgroundColor: Colors.grey.withOpacity(0.1),
                      valueColor:
                          const AlwaysStoppedAnimation<Color>(Colors.blue),
                      minHeight: 6,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}