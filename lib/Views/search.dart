import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search for courses...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey.withOpacity(0.1),
                ),
              ),
              const SizedBox(height: 20),
              const Text('Popular Searches:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 10),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  _buildSearchChip('Mathematics'),
                  _buildSearchChip('Programming'),
                  _buildSearchChip('Physics'),
                  _buildSearchChip('Chemistry'),
                  _buildSearchChip('English'),
                  _buildSearchChip('Web Development'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildSearchChip(String label) {
    return Chip(
      label: Text(label),
      backgroundColor: Colors.grey.withOpacity(0.1),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    );
  }
}