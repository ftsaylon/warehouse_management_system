// Author: Saylon, Francis T.
// Project Name: Solar Warehouse Management System

import 'package:flutter/material.dart';
import 'package:warehouse_management_system/screens/inventory_screen.dart';

import '../screens/projects_screen.dart';
import '../screens/accounts_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            leading: IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            elevation: 0,
            title: Text('Dashboard'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.contacts,
              color: Theme.of(context).accentColor,
            ),
            title: Text('Accounts'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(AccountsScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.assignment,
              color: Theme.of(context).accentColor,
            ),
            title: Text('Projects'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(ProjectsScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.home,
              color: Theme.of(context).accentColor,
            ),
            title: Text('Inventory'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(InventoryScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.folder_open,
              color: Theme.of(context).accentColor,
            ),
            title: Text('Quotations'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.folder,
              color: Theme.of(context).accentColor,
            ),
            title: Text('Job Orders'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.shopping_cart,
              color: Theme.of(context).accentColor,
            ),
            title: Text('Purchasing'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.local_shipping,
              color: Theme.of(context).accentColor,
            ),
            title: Text('Delivery'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.receipt,
              color: Theme.of(context).accentColor,
            ),
            title: Text('Billing'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.payment,
              color: Theme.of(context).accentColor,
            ),
            title: Text('Collection'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
        ],
      ),
    );
  }
}
