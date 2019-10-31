// Author: Saylon, Francis T.
// Project Name: Solar Warehouse Management System

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../modals/edit_material_modal.dart';
import '../providers/projects.dart';
import '../widgets/card_table.dart';
import '../widgets/materials_table.dart';

// Project Details Screen
class ProjectDetailScreen extends StatelessWidget {
  static const routeName = "/project-detail";

  _showAddEditModal(
      {BuildContext context, String projectId}) {
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
                      // Text(loadedProject.clientName),
                      Text(loadedProject.amount.toString()),
                      Text(loadedProject.expectedRevenue.toString()),
                      Text(loadedProject.closeDate.toString()),
                    ],
                  ),
                  RaisedButton(
                    child: Text("Add Material"),
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
