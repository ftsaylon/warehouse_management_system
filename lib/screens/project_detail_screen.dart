// Author: Saylon, Francis T.
// Project Name: Solar Warehouse Management System

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';

import '../modals/edit_material_modal.dart';
import '../providers/projects.dart';
import '../providers/accounts.dart';
import '../widgets/card_table.dart';
import '../widgets/materials_table.dart';

// Project Details Screen
class ProjectDetailScreen extends StatelessWidget {
  static const routeName = "/project-detail";

  _showAddEditModal({BuildContext context, String projectId}) {
    showDialog(
      context: context,
      builder: (BuildContext context) => EditMaterialModal(
        projectId: projectId,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final projectId = ModalRoute.of(context).settings.arguments as String;
    final loadedProject =
        Provider.of<Projects>(context, listen: false).findById(projectId);

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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        loadedProject.name,
                        style: Theme.of(context).textTheme.headline,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            "Client: ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            Provider.of<Accounts>(context)
                                .findById(loadedProject.accountId)
                                .accountName,
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            "Amount: ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            FlutterMoneyFormatter(
                              amount: loadedProject.amount,
                              settings: MoneyFormatterSettings(symbol: "₱"),
                            ).output.symbolOnLeft.toString(),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            "Expected Revenue: ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            FlutterMoneyFormatter(
                              amount: loadedProject.expectedRevenue,
                              settings: MoneyFormatterSettings(symbol: "₱"),
                            ).output.symbolOnLeft.toString(),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            "Close Date: ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            DateFormat(
                              'MM-dd-yyyy',
                            ).format(loadedProject.closeDate),
                          ),
                        ],
                      ),
                    ],
                  ),
                  RaisedButton(
                    child: Text("Add Material"),
                    elevation: 0,
                    onPressed: () {
                      _showAddEditModal(context: context, projectId: projectId);
                    },
                  ),
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
                  flex: 1,
                  child: CardTable(
                    label: "Materials",
                    table: MaterialsTable(projectId: loadedProject.id),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: CardTable(label: "Quotations"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
