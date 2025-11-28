import 'package:cloud_firestore/cloud_firestore.dart';

class Plan {
  final String id;
  final String title;
  final String subtitle;
  final String currentPrice;
  final String oldPrice;
  final List<String> features;
  final String type;
  final int durationInMonths;
  bool isExpanded;

  Plan({
    this.id = '',
    required this.title,
    required this.subtitle,
    required this.currentPrice,
    required this.oldPrice,
    required this.features,
    required this.type,
    required this.durationInMonths,
    this.isExpanded = false,
  });
}
