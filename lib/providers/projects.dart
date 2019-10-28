// Author: Saylon, Francis T. 
// Project Name: Solar Warehouse Management System

import 'package:flutter/material.dart';
import '../models/project.dart';

// Provider for Projects
class Projects with ChangeNotifier {
  List<Project> _items = [
    Project(
      id: 1.toString(),
      name: "Project Pegasus",
      clientName: "Solar Innovation Ads Corporation",
      accountId: 1.toString(), 
      materials: [
        "Tesseract",
        "Scepter",
        "Nick Fury",
        "Barton",
      ],
      quotations: [],
      amount: 100000,
      expectedRevenue: 100000,
      closeDate: DateTime.now().add(Duration(days: 10)),
      status: "Quotation"
    ),
    Project(
      id: 2.toString(),
      name: "Project Goliath",
      clientName: "Spindiv Kinetics",
      accountId: 2.toString(), 
      materials: [
        "Pym Particles",
        "Regulator",
        "Hank Pym",
        "Scott Lang",
      ],
      quotations: [],
      amount: 100000,
      expectedRevenue: 100000,
      closeDate: DateTime.now().add(Duration(days: 10)),
      status: "Quotation"
    ),
  ];

  // Getter for _items
  List<Project> get items {
    return [..._items];
  }

  // Get projects by client using account ID
  List<Project> getProjectsByClient(String accountId) {
    return _items.where((project) => project.accountId == accountId).toList();
  }

  // Get one project using project ID
  Project findById(String projectId) {
    return _items.firstWhere((project) => project.id == projectId);
  }
}
