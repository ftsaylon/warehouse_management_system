// Author: Saylon, Francis T.
// Project Name: Solar Warehouse Management System

import 'package:flutter/material.dart';

class CardTable extends StatelessWidget {
  const CardTable({
    Key key,
    this.label,
    this.table,
  }) : super(key: key);

  final String label;
  final Widget table;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                label,
                style: Theme.of(context).textTheme.headline,
              ),
              if(table != null) table,
            ],
          ),
        ),
      ),
    );
  }
}
