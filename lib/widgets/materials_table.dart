// Author: Saylon, Francis T.
// Project Name: Solar Warehouse Management System

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/projects.dart';

class MaterialsTable extends StatelessWidget {
  final String projectId;

  MaterialsTable({this.projectId});

  Widget build(BuildContext context) {
    final projectsData = projectId !=
            null // Checks if instantiated through other pages or through app drawer
        ? Provider.of<Projects>(context).getProjectsByClient(projectId)
        : Provider.of<Projects>(context).items;
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
              label: Text("Actions"),
            )
          ],
          rows: projectsData
              .map(
                (project) => DataRow(
                  cells: [
                    DataCell(
                      Text(project.name),
                      onTap: () {},
                    ),
                    DataCell(
                      Text(project.amount.toString()),
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
                              onPressed: () {
                                Provider.of<Projects>(context)
                                    .deleteProject(project.id);
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
