import 'package:flutter/foundation.dart';

class MaterialItem {
  final String id;
  final String name;
  final double amount;
  final int stock;

  MaterialItem({
    @required this.id,
    @required this.name,
    @required this.amount,
    @required this.stock,
  });
}
