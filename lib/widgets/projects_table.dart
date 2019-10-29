// Author: Saylon, Francis T.
// Project Name: Solar Warehouse Management System

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:warehouse_management_system/providers/accounts.dart';

import '../modals/edit_project_modal.dart';
import '../screens/project_detail_screen.dart';
import '../screens/account_detail_screen.dart';
import '../providers/projects.dart';

class ProjectsTable extends StatelessWidget {
  final String accountId;

  ProjectsTable({this.accountId});

  _showAddEditModal(BuildContext context, String id) {
    showDialog(
      context: context,
      builder: (BuildContext context) => EditProjectModal(projectId: id),
    );
  }

  @override
  Widget build(BuildContext context) {
    final projectsData = accountId !=
            null // Checks if instantiated through other pages or through app drawer
        ? Provider.of<Projects>(context).getProjectsByClient(accountId)
        : Provider.of<Projects>(context).items;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        DataTable(
          columns: [
            DataColumn(
              label: Text("Project Name"),
            ),
            DataColumn(
              label: Text("Client Name"),
            ),
            DataColumn(
              label: Text("Amount"),
            ),
            DataColumn(
              label: Text("Expected Revenue"),
            ),
            DataColumn(
              label: Text("Close Date"),
            ),
            DataColumn(
              label: Text("Status"),
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
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          ProjectDetailScreen.routeName,
                          arguments: project.id,
                        );
                      },
                    ),
                    DataCell(
                      Text(
                        Provider.of<Accounts>(context)
                            .findById(project.accountId)
                            .accountName,
                      ),
                      onTap: accountId == null
                          ? () {
                              Navigator.of(context).pushNamed(
                                AccountDetailScreen.routeName,
                                arguments: project.accountId,
                              );
                            }
                          : () {},
                    ),
                    DataCell(
                      Text(project.amount.toString()),
                      onTap: () {},
                    ),
                    DataCell(
                      Text(project.expectedRevenue.toString()),
                      onTap: () {},
                    ),
                    DataCell(
                      Text(
                        DateFormat(
                          'MM-dd-yyyy',
                        ).format(project.closeDate),
                      ),
                      onTap: () {},
                    ),
                    DataCell(
                      Text(project.status),
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
                                _showAddEditModal(context, project.id);
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
