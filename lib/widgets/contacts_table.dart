// Author: Saylon, Francis T.
// Project Name: Solar Warehouse Management System

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/accounts.dart';

class ContactsTable extends StatelessWidget {
  final String accountId;

  ContactsTable({this.accountId});

  @override
  Widget build(BuildContext context) {
    final contactsData = Provider.of<Accounts>(context).getContactsById(accountId);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        DataTable(
          columns: [
            DataColumn(
              label: Text("Contact Name"),
            ),
            DataColumn(
              label: Text("Contact Number"),
            ),
            DataColumn(
              label: Text("Actions"),
            )
          ],
          rows: contactsData
              .map(
                (contact) => DataRow(
                  cells: [
                    DataCell(
                      Text(contact.name),
                      onTap: () {},
                    ),
                    DataCell(
                      Text(contact.contactNumber),
                      onTap: () {},
                    ),
                    DataCell(
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            IconButton(
                              icon: Icon(Icons.edit),
                              color: Theme.of(context).primaryColor,
                              onPressed: () {},
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              color: Theme.of(context).errorColor,
                              onPressed: () {},
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
