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
    Account(
      id: "690af91d-6a24-4bc9-8ba1-342853a221e7",
      name: "Realpoint",
      contactNumber: "408-875-0161",
      category: "Client",
      address: "4 Dorton Parkway",
      industry: "Package Goods/Cosmetics",
      website:
          "http://cyberchimps.com/primis/in/faucibus/"),
    Account(
      id: "67a16d57-c276-4750-a37b-3575375ca3f5",
      name: "Eire",
      contactNumber: "318-893-4690",
      category: "Client",
      address: "01290 Manley Park",
      industry: "Electric Utilities: Central",
      website:
          "http://pen.io/turpis/donec/posuere"),
    Account(
      id: "b5106155-acbe-45d8-a260-cd1b7777c94c",
      name: "Mynte",
      contactNumber: "189-138-4960",
      category: "Client",
      address: "04 Algoma Terrace",
      industry: "Consumer Electronics/Appliances",
      website:
          "http://github.io/eget/rutrum/at/lorem"),
    Account(
      id: "1576bac8-7184-4f85-a006-53564a74c2e8",
      name: "Brightbean",
      contactNumber: "282-693-0604",
      category: "Supplier",
      address: "75311 Florence Hill",
      industry: "Oil Refining/Marketing",
      website:
          "http://infoseek.co.jp/leo/rhoncus.aspx"),
    Account(
      id: "291e33dd-7fb6-4b06-b3bd-48ca14d73bc2",
      name: "Ooba",
      contactNumber: "628-141-6021",
      category: "Client",
      address: "0380 Toban Center",
      industry: "Major Banks",
      website:
          "http://blog.com/nec/dui/luctus/"),
    Account(
      id: "fd854941-546a-42a6-a770-9a8ed8e43388",
      name: "Tagfeed",
      contactNumber: "533-576-3786",
      category: "Supplier",
      address: "5 Hoffman Trail",
      industry: "Oil & Gas Production",
      website: "http://va.gov/enim.aspx?dui=tellus",
    ),
    Account(
      id: "2ddfb778-bc18-441f-b74a-9a35ecb55e37",
      name: "Quamba",
      contactNumber: "703-911-5532",
      category: "Client",
      address: "5174 Sutteridge Drive",
      industry: "Electric Utilities: Central",
      website:
          "http://reverbnation.com/faucibus/"),
    Account(
      id: "dd08a705-c764-4a92-8740-6feea25d0e01",
      name: "Brainbox",
      contactNumber: "447-429-1198",
      category: "Client",
      address: "28 Rieder Park",
      industry: "n/a",
      website:
          "https://cisco.com/ligula/pellentesque.jpg"),
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
