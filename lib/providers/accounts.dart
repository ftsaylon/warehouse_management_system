// Author: Saylon, Francis T. 
// Project Name: Solar Warehouse Management System

import 'package:flutter/material.dart';

import '../models/address.dart';
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
      address: Address(
          street: "Panapaan IV",
          city: "Bacoor",
          province: "Cavite",
          country: "Philippines",
          postalCode: 4102),
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
      address: Address(
          street: "Guevarra St.",
          city: "Dasmariñas City",
          province: "Cavite",
          country: "Philippines",
          postalCode: 4114),
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

  // Get contacts by account ID
  List<Contact> getContactsById(String id) {
    return [...findById(id).contacts];
  }

  // Get one account using account ID
  Account findById(String id) {
    return _items.firstWhere((account) => account.id == id);
  }

}
