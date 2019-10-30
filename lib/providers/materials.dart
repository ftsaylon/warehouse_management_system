// Author: Saylon, Francis T.
// Project Name: Solar Warehouse Management System

import 'package:flutter/material.dart';
import '../models/material_item.dart';

class Materials with ChangeNotifier {
  List<MaterialItem> _items = [
    MaterialItem(
      id: 1.toString(),
      name: "Tarpaulin",
      amount: 1000,
    ),
    MaterialItem(
      id: 2.toString(),
      name: "Vinyl",
      amount: 340,
    ),
    MaterialItem(
      id: 3.toString(),
      name: "Ink",
      amount: 500,
    ),
  ];

  List<MaterialItem> get items {
    return [..._items];
  }

  Future<void> addMaterial(MaterialItem materialItem) async {
    final newMaterial = MaterialItem(
      id: DateTime.now().toString(),
      name: materialItem.name,
      amount: materialItem.amount,
    );

    _items.add(newMaterial);
    notifyListeners();
  }

  MaterialItem findById(String materialId) {
    return _items.firstWhere((material) => material.id == materialId);
  }
}
