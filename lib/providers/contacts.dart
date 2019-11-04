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

  Future<void> addContact(Contact contact) async {
    final newContact = Contact(
      id: DateTime.now().toString(),
      name: contact.name,
      contactNumber: contact.contactNumber,
      accountId: contact.accountId,
    );
    _items.add(newContact);
    notifyListeners();
  }

    Future<void> updateContact(Contact newContact) async {
    final String id = newContact.id;
    final contactIndex = _items.indexWhere((contact) => contact.id == id);
    if (contactIndex >= 0) {
      _items[contactIndex] = newContact;
      notifyListeners();
    }
  }

  // Function for deleting an account
  void deleteContact(String id) {
    final existingContactIndex =
        _items.indexWhere((contact) => contact.id == id);
    _items.removeAt(existingContactIndex);
    notifyListeners();
  }

  // Get one account using account ID
  Contact findById(String id) {
    return _items.firstWhere((account) => account.id == id);
  }

  List<Contact> getContactsByAccountId(String id) {
    return [..._items.where((contact) => contact.accountId == id)];
  }
}
