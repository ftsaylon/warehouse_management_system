// Author: Saylon, Francis T.
// Project Name: Solar Warehouse Management System

import 'package:flutter/material.dart';

import '../widgets/app_drawer.dart';
import '../widgets/materials_table.dart';
import '../modals/edit_material_modal.dart';

class InventoryScreen extends StatelessWidget {
  static const routeName = "/inventory";

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
    return Scaffold(
      appBar: AppBar(
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
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.home,
                      color: Theme.of(context).accentColor,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Inventory",
                      style: Theme.of(context).textTheme.headline,
                    ),
                  ],
                ),
                RaisedButton(
                  child: Text("Add New Material"),
                  elevation: 0,
                  onPressed: () {
                    _showAddEditModal(context: context);
                  },
                ),
              ],
            ),
            MaterialsTable(),
          ],
        ),
      ),
      drawer: AppDrawer(),
    );
  }
}
