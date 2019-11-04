// Author: Saylon, Francis T.
// Project Name: Solar Warehouse Management System

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warehouse_management_system/modals/edit_contact_modal.dart';

import '../providers/contacts.dart';

class ContactsTable extends StatelessWidget {
  final String accountId;

  ContactsTable({this.accountId});

  _showAddEditModal(BuildContext context, Widget modal) {
    showDialog(
      context: context,
      builder: (BuildContext context) => modal,
    );
  }

  @override
  Widget build(BuildContext context) {
    final contactsData =
        Provider.of<Contacts>(context).getContactsByAccountId(accountId);
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
                              onPressed: () {
                                _showAddEditModal(
                                  context,
                                  EditContactModal(
                                    contactId: contact.id,
                                    accountId: contact.accountId,
                                  ),
                                );
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              color: Theme.of(context).errorColor,
                              onPressed: () {
                                Provider.of<Contacts>(context, listen: false)
                                    .deleteContact(contact.id);
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
