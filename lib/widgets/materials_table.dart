// Author: Saylon, Francis T.
// Project Name: Solar Warehouse Management System

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warehouse_management_system/modals/edit_material_modal.dart';
import 'package:warehouse_management_system/providers/materials.dart';

import '../providers/projects.dart';

class MaterialsTable extends StatelessWidget {
  final String projectId;

  MaterialsTable({this.projectId});

  _showAddEditModal(
      {BuildContext context, String projectId, String materialId}) {
    showDialog(
      context: context,
      builder: (BuildContext context) => EditMaterialModal(
        projectId: projectId,
        materialId: materialId,
      ),
    );
  }

  Widget build(BuildContext context) {
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
              label: projectId != null ? Text("Quantity") : Text("Stocks"),
            ),
            if (projectId != null)
              DataColumn(
                label: Text("SubTotal"),
              ),
            DataColumn(
              label: Text("Actions"),
            )
          ],
          rows: projectId != null
              ? Provider.of<Projects>(context)
                  .findById(projectId)
                  .getMaterialsByProject()
                  .entries
                  .map(
                    (material) => DataRow(
                      cells: _dataCellBuilder(
                        context,
                        material.key,
                        material.value,
                      ),
                    ),
                  )
                  .toList()
              : Provider.of<Materials>(context)
                  .items
                  .map(
                    (material) => DataRow(
                      cells: _dataCellBuilder(
                        context,
                        material.id,
                        material.stock,
                      ),
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
      if (projectId != null)
        DataCell(
          Text((materialData.amount * quantity).toString()),
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
                    context: context,
                    projectId: projectId,
                    materialId: materialData.id,
                  );
                },
              ),
              IconButton(
                icon: Icon(Icons.delete),
                color: Theme.of(context).errorColor,
                onPressed: projectId == null
                    ? () {
                        Provider.of<Materials>(context, listen: false)
                            .deleteMaterial(materialData.id);
                        Provider.of<Projects>(context, listen:false).deleteMaterialInAllProjects(materialId);
                      }
                    : () {
                        Provider.of<Projects>(context, listen: false).deleteMaterialInProject(
                            projectId, materialData.id);
                      },
              ),
            ],
          ),
        ),
      ),
    ];
  }
}
