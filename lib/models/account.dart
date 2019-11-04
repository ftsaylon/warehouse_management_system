// Author: Saylon, Francis T. 
// Project Name: Solar Warehouse Management System

import 'package:flutter/foundation.dart';

// import './contact.dart';

// Model for Account Class
class Account {
  final String id;
  final String name;
  final String category;
  final String website;
  final String industry;
  final String contactNumber;
  final String address;
  List<String> projects;

  Account({
    @required this.id,
    @required this.name,
    @required this.contactNumber,
    @required this.category,
    this.website,
    @required this.industry,
    @required this.address,
    this.projects,
  });

  String get accountName {
    return name;
  }
}
