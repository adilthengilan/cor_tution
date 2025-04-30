import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:intl/intl.dart';

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

// Classes Screen Implementation
class ClassesScreen extends StatelessWidget {
  final String? subjectFilter;
  
  const ClassesScreen({Key? key, this.subjectFilter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String title = subjectFilter != null ? '$subjectFilter Classes' : 'Available Classes';
    
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              subjectFilter != null ? '$subjectFilter Courses' : 'Class 10 Subjects',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 20),
            ClassVideoCard(
              subjectName: subjectFilter ?? 'Mathematics',
              className: 'Class 10',
              chapterName: 'Chapter 1: Real Numbers',
              color: Colors.blue,
              onTap: () {
                // Navigate to specific chapter or video player
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Opening Mathematics video')),
                );
              },
            ),
            const SizedBox(height: 15),
            ClassVideoCard(
              subjectName: subjectFilter ?? 'Physics',
              className: 'Class 10',
              chapterName: 'Chapter 1: Light - Reflection and Refraction',
              color: Colors.green,
              onTap: () {
                // Navigate to specific chapter or video player
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Opening Physics video')),
                );
              },
            ),
            const SizedBox(height: 15),
            ClassVideoCard(
              subjectName: subjectFilter ?? 'Chemistry',
              className: 'Class 10',
              chapterName: 'Chapter 1: Chemical Reactions and Equations',
              color: Colors.red,
              onTap: () {
                // Navigate to specific chapter or video player
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Opening Chemistry video')),
                );
              },
            ),
            const SizedBox(height: 15),
            ClassVideoCard(
              subjectName: subjectFilter ?? 'Computer Science',
              className: 'Class 10',
              chapterName: 'Chapter 1: Introduction to Programming',
              color: Colors.purple,
              onTap: () {
                // Navigate to specific chapter or video player
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Opening Computer Science video')),
                );
              },
            ),
            if (subjectFilter == "Programming" || subjectFilter == null)
              Column(
                children: [
                  const SizedBox(height: 15),
                  ClassVideoCard(
                    subjectName: 'Programming',
                    className: 'Web Development',
                    chapterName: 'HTML and CSS Basics',
                    color: Colors.orange,
                    onTap: () {
                      // Navigate to specific chapter or video player
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Opening Web Development video')),
                      );
                    },
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class ClassVideoCard extends StatelessWidget {
  final String subjectName;
  final String className;
  final String chapterName;
  final Color color;
  final VoidCallback? onTap;

  const ClassVideoCard({
    Key? key,
    required this.subjectName,
    required this.className,
    required this.chapterName,
    required this.color,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 200,
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: color, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Video play button
            Center(
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.play_arrow,
                  size: 40,
                  color: color,
                ),
              ),
            ),
            // Class details
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.8),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      subjectName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '$className • $chapterName',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
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
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            _buildCourseListItem(
              context,
              'Mathematics',
              'Basic to Advanced Math for all grades',
              Icons.calculate,
              Colors.blue,
            ),
            _buildCourseListItem(
              context,
              'Science',
              'Physics, Chemistry and Biology',
              Icons.science,
              Colors.green,
            ),
            _buildCourseListItem(
              context,
              'Programming',
              'Web, Mobile and Desktop Development',
              Icons.code,
              Colors.purple,
            ),
            _buildCourseListItem(
              context,
              'Languages',
              'English, French, Spanish and more',
              Icons.language,
              Colors.orange,
            ),
            _buildCourseListItem(
              context,
              'Design',
              'UI/UX, Graphic Design and Art',
              Icons.design_services,
              Colors.pink,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCourseListItem(BuildContext context, String title, String description, IconData iconData, Color color) {
    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(iconData, color: color, size: 28),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Text(
          description,
          style: TextStyle(color: Colors.grey[600], fontSize: 14),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ClassesScreen(subjectFilter: title),
            ),
          );
        },
      ),
    );
  }
}