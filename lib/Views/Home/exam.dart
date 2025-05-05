
import 'package:corona_lms/views/Home/exampage.dart';
import 'package:flutter/material.dart';


class ExamsScreen extends StatelessWidget {
  const ExamsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // List of available exams
    final List<Map<String, dynamic>> exams = [
      {
        'title': '10th Chemistry - Chemical Reactions',
        'subject': 'Chemistry',
        'duration': '30 minutes',
        'questions': 5,
        'color': Colors.purple,
        'icon': Icons.science
      },
      {
        'title': '10th Chemistry - Periodic Table',
        'subject': 'Chemistry',
        'duration': '25 minutes',
        'questions': 5,
        'color': Colors.blue,
        'icon': Icons.table_chart
      },
      {
        'title': '10th Chemistry - Acids and Bases',
        'subject': 'Chemistry',
        'duration': '35 minutes',
        'questions': 5,
        'color': Colors.green,
        'icon': Icons.science_outlined
      },
      {
        'title': '10th Chemistry - Carbon Compounds',
        'subject': 'Chemistry',
        'duration': '40 minutes',
        'questions': 5,
        'color': Colors.orange,
        'icon': Icons.hexagon
      },
      {
        'title': '10th Chemistry - Metals',
        'subject': 'Chemistry',
        'duration': '30 minutes',
        'questions': 5,
        'color': Colors.red,
        'icon': Icons.blur_circular
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Available Exams'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Container(
        color: Colors.white,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Kerala State Syllabus',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  '10th Standard Chemistry Exams',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(height: 30),
                Expanded(
                  child: ListView.builder(
                    itemCount: exams.length,
                    itemBuilder: (context, index) {
                      final exam = exams[index];
                      return _buildExamCard(
                        context,
                        exam['title'],
                        exam['subject'],
                        exam['duration'],
                        exam['questions'],
                        exam['color'],
                        exam['icon'],
                        index,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildExamCard(
    BuildContext context,
    String title,
    String subject,
    String duration,
    int questionCount,
    Color color,
    IconData icon,
    int examIndex,
  ) {
    return GestureDetector(
      onTap: () {
        // Navigate to the exam page when an exam card is tapped
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ExamPage(
              examTitle: title,
              examIndex: examIndex,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              spreadRadius: 1,
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(
            color: color.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Icon(
                icon,
                color: color,
                size: 30,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _buildExamDetail(Icons.subject, subject),
                      const SizedBox(width: 15),
                      _buildExamDetail(Icons.timer, duration),
                      const SizedBox(width: 15),
                      _buildExamDetail(
                          Icons.help_outline, '$questionCount Questions'),
                    ],
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.black54,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExamDetail(IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          size: 14,
          color: Colors.black54,
        ),
        const SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[700],
          ),
        ),
      ],
    );
  }
}
