import 'package:flutter/material.dart';

class VideoPlayerScreen extends StatelessWidget {
  final String subjectName;
  final String className;
  final String chapterName;
  
  const VideoPlayerScreen({
    super.key,
    required this.subjectName,
    required this.className,
    required this.chapterName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(subjectName),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Mock video player area
          Container(
            width: double.infinity,
            height: 250,
            color: Colors.black,
            child: const Center(
              child: Icon(
                Icons.play_circle_fill,
                size: 70,
                color: Colors.white,
              ),
            ),
          ),
          
          // Video details
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  chapterName,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '$className • $subjectName',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'In this lesson, you will learn the fundamental concepts of this chapter. The video covers all important topics and includes solved examples to help you understand the concepts better.',
                  style: TextStyle(fontSize: 16),
                ),
                
                const SizedBox(height: 24),
                const Text(
                  'Related Videos',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                
                // Related videos list
                SizedBox(
                  height: 120,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _buildRelatedVideoItem('Solved Examples'),
                      _buildRelatedVideoItem('Numerical Problems'),
                      _buildRelatedVideoItem('Quiz'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildRelatedVideoItem(String title) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      width: 160,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.play_circle_outline, size: 40),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text('$subjectName • $chapterName'),
        ],
      ),
    );
  }
}