// Author: Saylon, Francis T.
// Project Name: Solar Warehouse Management System

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/accounts.dart';
import '../widgets/contacts_table.dart';
import '../widgets/projects_table.dart';
import '../widgets/card_table.dart';

// Screen for Account Details
class AccountDetailScreen extends StatelessWidget {
  static const routeName = "/account-detail";

  @override
  Widget build(BuildContext context) {
    final accountId = ModalRoute.of(context).settings.arguments
        as String; // Get account ID from arguments
    final loadedAccount = Provider.of<Accounts>(context, listen: false)
        .findById(
            accountId); // Load account using Account Provider and account ID
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              // Account Details
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    loadedAccount.name,
                    style: Theme.of(context).textTheme.headline,
                  ),
                  Text("${loadedAccount.category}"),
                  Text("${loadedAccount.address}"),
                  Text("${loadedAccount.industry}"),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: CardTable(
                    label: "Projects",
                    table: ProjectsTable(
                      accountId: accountId,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: CardTable(
                    label: "Contacts",
                    table: ContactsTable(
                      accountId: accountId,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
