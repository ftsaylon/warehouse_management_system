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
        accountId: 1.toString(),
        materials: [
          1.toString(),
          2.toString(),
          3.toString(),
          4.toString(),
        ],
        quotations: [],
        amount: 100000,
        expectedRevenue: 100000,
        closeDate: DateTime.now().add(Duration(days: 10)),
        status: "Quotation"),
    Project(
        id: 2.toString(),
        name: "Project Goliath",
        accountId: 2.toString(),
        materials: [
          5.toString(),
          6.toString(),
          7.toString(),
          8.toString(),
        ],
        quotations: [],
        amount: 100000,
        expectedRevenue: 100000,
        closeDate: DateTime.now().add(Duration(days: 10)),
        status: "Quotation"),
  ];

  // Getter for _items
  List<Project> get items {
    return [..._items];
  }

  Future<void> addProject(Project project) async {
    final newProject = Project(
      id: DateTime.now().toString(),
      name: project.name,
      accountId: project.accountId,
      materials: project.materials,
      quotations: project.quotations,
      amount: project.amount,
      expectedRevenue: project.expectedRevenue,
      closeDate: project.closeDate,
      status: project.status,
    );

    _items.add(newProject);
    notifyListeners();
  }

  Future<void> updateProject(Project newProject) async {
    final String id = newProject.id;
    final projectIndex = _items.indexWhere((project) => project.id == id);
    if (projectIndex >= 0) {
      _items[projectIndex] = newProject;
      notifyListeners();
    }
  }

  // Function for deleting an account
  void deleteProject(String id) {
    final existingProjectIndex =
        _items.indexWhere((project) => project.id == id);
    _items.removeAt(existingProjectIndex);
    notifyListeners();
  }

  // Get projects by client using account ID
  List<Project> getProjectsByClient(String accountId) {
    return [..._items.where((project) => project.accountId == accountId)];
  }

  // Get one project using project ID
  Project findById(String projectId) {
    return _items.firstWhere((project) => project.id == projectId);
  }
}
