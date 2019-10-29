// Author: Saylon, Francis T.
// Project Name: Solar Warehouse Management System

import 'package:flutter/material.dart';

import '../widgets/app_drawer.dart';
import '../widgets/accounts_table.dart';
import '../modals/edit_account_modal.dart';

// List of Accounts Screen
class AccountsScreen extends StatelessWidget {
  static const String routeName = "/accounts";

  _showAddEditModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => EditAccountModal(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text("Accounts"),
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Accounts",
                  style: Theme.of(context).textTheme.headline,
                ),
                RaisedButton(
                  child: Text("Add New Account"),
                  elevation: 0,
                  onPressed: () {
                    _showAddEditModal(context);
                  },
                ),
              ],
            ),
            AccountsTable(),
          ],
        ),
      ),
      drawer: AppDrawer(),
    );
  }
}
