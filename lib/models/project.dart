// Author: Saylon, Francis T.
// Project Name: Solar Warehouse Management System

import 'package:flutter/foundation.dart';

// Model for Project Class
class Project with ChangeNotifier {
  final String id;
  final String name;
  final String accountId;
  Map<String, int> materials;
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

  Future<void> updateMaterialQuantity(
    String materialId,
    int newQuantity,
  ) async {
    if (materials.containsKey(materialId)) {
      materials.update(materialId, (quantity) => newQuantity);
    } else {
      materials.putIfAbsent(materialId, () => newQuantity);
    }
    notifyListeners();
  }

  // Getting the materials with quantities
  Map<String, int> getMaterialsByProject() {
    return materials;
  }
}
