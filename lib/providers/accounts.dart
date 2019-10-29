// Author: Saylon, Francis T.
// Project Name: Solar Warehouse Management System

import 'package:flutter/material.dart';

import '../models/account.dart';
import '../models/contact.dart';

// Accounts Provider
class Accounts with ChangeNotifier {
  // List of Accounts
  List<Account> _items = [
    Account(
      id: 1.toString(),
      name: "Solar Innovation Ads Corporation",
      contactNumber: "09390959794",
      category: "Client",
      address: "Panapaan IV, Bacoor, Cavite, Philippines, 4102",
      industry: "Advertising",
      website: "https://solarads.com.ph",
      contacts: [
        Contact(
          id: DateTime.now().toString(),
          name: "Francis Saylon",
          contactNumber: "09390959794",
        ),
        Contact(
          id: DateTime.now().toString(),
          name: "Ramon Cantanjal",
          contactNumber: "09390959794",
        ),
      ],
    ),
    Account(
      id: 2.toString(),
      name: "Spindiv Kinetics",
      contactNumber: "09390959794",
      category: "Supplier",
      address: "Panapaan IV, Bacoor, Cavite, Philippines, 4102",
      industry: "Tech",
      website: "https://spindiv.com.ph",
      contacts: [
        Contact(
          id: DateTime.now().toString(),
          name: "Ramon Cantanjal",
          contactNumber: "09390959794",
        ),
      ],
    ),
  ];

  // Getter for _items
  List<Account> get items {
    return [..._items];
  }

  // Function for adding a new account
  Future<void> addAccount(Account account) async {
    final newAccount = Account(
      id: DateTime.now().toString(),
      name: account.name,
      contactNumber: account.contactNumber,
      category: account.category,
      address: account.address,
      industry: account.industry,
      website: account.website,
      contacts: account.contacts,
    );

    _items.add(newAccount);
    notifyListeners();
  }

  Future<void> updateAccount(String id, Account newAccount) async {
    final prodIndex = _items.indexWhere((account) => account.id == id);
    if (prodIndex >= 0) {
      _items[prodIndex] = newAccount;
      notifyListeners();
    }
  }

  // Function for deleting an account
  void deleteAccount(String id) {
    final existingAccountIndex =
        _items.indexWhere((account) => account.id == id);
    _items.removeAt(existingAccountIndex);
    notifyListeners();
  }

  // Get contacts by account ID
  List<Contact> getContactsById(String id) {
    return [...findById(id).contacts];
  }

  // Get one account using account ID
  Account findById(String id) {
    return _items.firstWhere((account) => account.id == id);
  }
}
