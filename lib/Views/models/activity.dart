import 'package:flutter/material.dart';

class ActivityItem {
  final String title;
  final String description;
  final DateTime date;
  final IconData icon;
  final Color iconColor;
  final bool isNew;

  ActivityItem({
    required this.title,
    required this.description,
    required this.date,
    required this.icon,
    required this.iconColor,
    this.isNew = false,
  });
}