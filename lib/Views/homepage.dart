import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:intl/intl.dart'; // Add this for date formatting

// Define a Notification class to manage notification data
class NotificationItem {
  final String title;
  final String message;
  final DateTime date;
  final bool isRead;

  NotificationItem({
    required this.title,
    required this.message,
    required this.date,
    this.isRead = false,
  });
}

// Define all the screens needed for navigation
class CoursesScreen extends StatelessWidget {
  const CoursesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Courses'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Container(
        color: Colors.white,
        child: const Center(
          child: Text('Courses Screen',
              style: TextStyle(color: Colors.black, fontSize: 24)),
        ),
      ),
    );
  }
}

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Container(
        color: Colors.white,
        child: const Center(
          child: Text('Favorites Screen',
              style: TextStyle(color: Colors.black, fontSize: 24)),
        ),
      ),
    );
  }
}

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Container(
        color: Colors.white,
        child: const Center(
          child: Text('Search Screen',
              style: TextStyle(color: Colors.black, fontSize: 24)),
        ),
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Container(
        color: Colors.white,
        child: const Center(
          child: Text('Settings Screen',
              style: TextStyle(color: Colors.black, fontSize: 24)),
        ),
      ),
    );
  }
}

// New Notifications Screen
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

// Main navigation class that will handle the bottom navigation
class MainNavigation extends StatefulWidget {
  const MainNavigation({Key? key}) : super(key: key);

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  // List of screens corresponding to each navigation item
  final List<Widget> _screens = [
    const HomeScreen(),
    const CoursesScreen(),
    const FavoritesScreen(),
    const SearchScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white,
        color: Colors.white,
        buttonBackgroundColor: Colors.white,
        height: 60,
        animationDuration: const Duration(milliseconds: 300),
        index: _currentIndex,
        items: const <Widget>[
          Icon(Icons.home, size: 30, color: Colors.black),
          Icon(Icons.book, size: 30, color: Colors.black),
          Icon(Icons.favorite, size: 30, color: Colors.black),
          Icon(Icons.search, size: 30, color: Colors.black),
          Icon(Icons.settings, size: 30, color: Colors.black),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

// HomeScreen with updated theme and colors
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

  // Add ScrollController for course cards
  final ScrollController _courseScrollController = ScrollController();

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

  // Variable to track if notification alert is visible
  bool _showNotificationAlert = true;
  int _unreadNotificationsCount = 0;

  @override
  void initState() {
    super.initState();
    // Calculate unread notifications count
    _unreadNotificationsCount = _notifications.where((n) => !n.isRead).length;
  }

  // Function to scroll the courses list to the left
  void _scrollLeft() {
    if (_courseScrollController.hasClients) {
      final currentPosition = _courseScrollController.offset;
      final scrollAmount = currentPosition - 200.0;
      _courseScrollController.animateTo(
        scrollAmount < 0 ? 0 : scrollAmount,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  // Function to scroll the courses list to the right
  void _scrollRight() {
    if (_courseScrollController.hasClients) {
      final currentPosition = _courseScrollController.offset;
      final scrollAmount = currentPosition + 200.0;
      _courseScrollController.animateTo(
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
                            children: [
                              const Icon(Icons.notifications_active,
                                  color: Colors.blue),
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
                                icon:
                                    const Icon(Icons.close, color: Colors.grey),
                                onPressed: _dismissNotificationAlert,
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
                                  onPressed: _scrollLeft,
                                ),
                                IconButton(
                                  icon: const Icon(Icons.arrow_forward_ios,
                                      color: Colors.black, size: 18),
                                  onPressed: _scrollRight,
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
                    const SizedBox(height: 20),
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
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
