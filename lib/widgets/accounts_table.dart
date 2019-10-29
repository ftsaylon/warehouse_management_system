// Author: Saylon, Francis T.
// Project Name: Solar Warehouse Management System

import 'dart:html' as html;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../modals/edit_account_modal.dart';
import '../screens/account_detail_screen.dart';
import '../providers/accounts.dart';

class AccountsTable extends StatelessWidget {
  _showAddEditModal(BuildContext context, String id) {
    showDialog(
      context: context,
      builder: (BuildContext context) => EditAccountModal(accountId: id),
    );
  }

  @override
  Widget build(BuildContext context) {
    final accountsData = Provider.of<Accounts>(context).items;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        DataTable(
          columns: [
            DataColumn(
              label: Text("Account Name"),
            ),
            DataColumn(
              label: Text("Account Type"),
            ),
            DataColumn(
              label: Text("Contact Number"),
            ),
            DataColumn(
              label: Text("Website"),
            ),
            DataColumn(
              label: Text("Actions"),
            )
          ],
          rows: accountsData
              .map(
                (account) => DataRow(
                  cells: [
                    DataCell(
                      Text(account.name),
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          AccountDetailScreen.routeName,
                          arguments: account.id,
                        );
                      },
                    ),
                    DataCell(
                      Text(account.category),
                      onTap: () {},
                    ),
                    DataCell(
                      Text(account.contactNumber),
                      onTap: () {},
                    ),
                    DataCell(
                      Text(
                        account.website,
                        style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      onTap: () {
                        html.window.open(account.website, account.website);
                      },
                    ),
                    DataCell(
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            IconButton(
                              icon: Icon(Icons.edit),
                              color: Theme.of(context).primaryColor,
                              onPressed: () {
                                _showAddEditModal(context, account.id);
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              color: Theme.of(context).errorColor,
                              onPressed: () {
                                Provider.of<Accounts>(context, listen: false)
                                    .deleteAccount(account.id);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
