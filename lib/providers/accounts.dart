// Author: Saylon, Francis T.
// Project Name: Solar Warehouse Management System

import 'package:flutter/material.dart';

import '../models/account.dart';

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
    ),
    Account(
      id: 2.toString(),
      name: "Spindiv Kinetics",
      contactNumber: "09390959794",
      category: "Supplier",
      address: "Panapaan IV, Bacoor, Cavite, Philippines, 4102",
      industry: "Tech",
      website: "https://spindiv.com.ph",
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
    );

    _items.add(newAccount);
    notifyListeners();
  }

  Future<void> updateAccount(Account newAccount) async {
    final String id = newAccount.id;
    final accountIndex = _items.indexWhere((account) => account.id == id);
    if (accountIndex >= 0) {
      _items[accountIndex] = newAccount;
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

  // Get one account using account ID
  Account findById(String id) {
    return _items.firstWhere((account) => account.id == id);
  }
}
