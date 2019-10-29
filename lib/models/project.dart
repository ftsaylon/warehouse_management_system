// Author: Saylon, Francis T. 
// Project Name: Solar Warehouse Management System

import 'package:flutter/foundation.dart';

// Model for Project Class
class Project {
  final String id;
  final String name;
  final String accountId;
  List<String> materials;
  List<String> quotations;
  final double amount;
  final double expectedRevenue;
  final DateTime closeDate;
  final String status;

  Project({
    @required this.id,
    @required this.name,
    @required this.accountId,
    @required this.materials,
    @required this.quotations,
    @required this.amount,
    @required this.expectedRevenue,
    @required this.closeDate,
    @required this.status,
  });
}
