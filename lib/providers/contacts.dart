// Author: Saylon, Francis T.
// Project Name: Solar Warehouse Management System

import 'package:flutter/material.dart';

import '../models/contact.dart';

class Contacts with ChangeNotifier {
  List<Contact> _items = [
    Contact(
      id: 1.toString(),
      name: "Francis Saylon",
      contactNumber: "09390959794",
      accountId: 1.toString(),
    ),
    Contact(
      id: 2.toString(),
      name: "Ramon Cantanjal",
      contactNumber: "09390959794",
      accountId: 1.toString(),
    ),
  ];

  List<Contact> get items {
    return [..._items];
  }

  // Get one account using account ID
  Contact findById(String id) {
    return _items.firstWhere((account) => account.id == id);
  }

  List<Contact> getContactsByAccountId(String id) {
    return [..._items.where((contact) => contact.accountId == id)];
  }
}
