// Author: Saylon, Francis T.
// Project Name: Solar Warehouse Management System

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warehouse_management_system/providers/materials.dart';

import '../providers/projects.dart';

class MaterialsTable extends StatelessWidget {
  final String projectId;

  MaterialsTable({this.projectId});

  Widget build(BuildContext context) {
    final materialsData = Provider.of<Projects>(context)
        .findById(projectId)
        .getMaterialsByProject();
    print(materialsData);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        DataTable(
          columns: [
            DataColumn(
              label: Text("Item Name"),
            ),
            DataColumn(
              label: Text("Amount"),
            ),
            DataColumn(
              label: Text("Quantity"),
            ),
            DataColumn(
              label: Text("Actions"),
            )
          ],
          rows: materialsData.entries
              .map(
                (material) => DataRow(
                  cells: _dataCellBuilder(context, material.key, material.value),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
  
  List<DataCell> _dataCellBuilder(
      BuildContext context, String materialId, int quantity) {
    final materialData = Provider.of<Materials>(context).findById(materialId);
    return [
      DataCell(
        Text(materialData.name),
        onTap: () {},
      ),
      DataCell(
        Text(materialData.amount.toString()),
        onTap: () {},
      ),
      DataCell(
        Text(quantity.toString()),
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
                  // _showAddEditModal(context, project.id);
                },
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
    ];
  }
}
