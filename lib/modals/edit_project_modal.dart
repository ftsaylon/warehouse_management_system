import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

import '../models/project.dart';
import '../providers/projects.dart';
import '../providers/accounts.dart';

class EditProjectModal extends StatefulWidget {
  final String projectId;

  EditProjectModal({this.projectId});

  @override
  _EditProjectModalState createState() => _EditProjectModalState();
}

class _EditProjectModalState extends State<EditProjectModal> {
  final _form = GlobalKey<FormState>();

  var _editedProject = Project(
    id: null,
    name: '',
    accountId: null,
    materials: {},
    quotations: [],
    amount: 0.0,
    expectedRevenue: 0.0,
    closeDate: DateTime.now(),
    status: '',
  );

  var _initValues = {
    'name': '',
    'clientName': '',
    'accountId': '',
    'materials': {},
    'quotations': [],
    'amount': '',
    'expectedRevenue': '',
    'closeDate': '',
    'status': '',
  };

  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      if (widget.projectId != null) {
        _editedProject = Provider.of<Projects>(context, listen: false)
            .findById(widget.projectId);
        _initValues = {
          'name': _editedProject.name,
          'accountId': _editedProject.accountId,
          'materials': _editedProject.materials,
          'quotations': _editedProject.quotations,
          'amount': _editedProject.amount,
          'expectedRevenue': _editedProject.expectedRevenue,
          'closeDate': _editedProject.closeDate,
          'status': _editedProject.status,
        };
      }
    }
    super.didChangeDependencies();
  }

  Future<void> _saveForm() async {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    setState(() {
      _isLoading = true;
    });
    if (_editedProject.id != null) {
      await Provider.of<Projects>(context, listen: false)
          .updateProject(_editedProject);
    } else {
      try {
        await Provider.of<Projects>(context, listen: false)
            .addProject(_editedProject);
      } catch (e) {
        await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('An error occurred!'),
            content: Text('Something went wrong.'),
            actions: <Widget>[
              FlatButton(
                child: Text('Okay'),
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
              )
            ],
          ),
        );
      }
    }
    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    var accountChoices = Provider.of<Accounts>(context).items.map(
      (item) {
        return DropdownMenuItem<String>(
          value: item.id,
          child: Text(item.name),
        );
      },
    ).toList();

    return Dialog(
      child: Container(
        height: 670,
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.all(20),
        child: _isLoading
            ? CircularProgressIndicator()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _editedProject.id != null
                      ? Text(
                          "Edit Project",
                          style: Theme.of(context).textTheme.headline,
                        )
                      : Text(
                          "Add Project",
                          style: Theme.of(context).textTheme.headline,
                        ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    height: 600,
                    width: 600,
                    child: Form(
                      key: _form,
                      child: ListView(
                        children: <Widget>[
                          TextFormField(
                            initialValue: _initValues['name'],
                            decoration: InputDecoration(labelText: "Name"),
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Please provide a value.";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _editedProject = Project(
                                id: _editedProject.id,
                                name: value,
                                accountId: _editedProject.accountId,
                                materials: _editedProject.materials,
                                quotations: _editedProject.quotations,
                                amount: _editedProject.amount,
                                expectedRevenue: _editedProject.expectedRevenue,
                                closeDate: _editedProject.closeDate,
                                status: _editedProject.status,
                              );
                            },
                          ),
                          // if (widget.projectId ==
                          //     null) // Checks if editing the project. Account can't be changed.
                          DropdownButtonFormField(
                            items: accountChoices,
                            value: _editedProject.accountId,
                            decoration: InputDecoration(labelText: "Account"),
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Please provide a value.";
                              }
                              return null;
                            },
                            onChanged: (value) {
                              setState(() {
                                _editedProject = Project(
                                  id: _editedProject.id,
                                  name: _editedProject.name,
                                  accountId: value,
                                  materials: _editedProject.materials,
                                  quotations: _editedProject.quotations,
                                  amount: _editedProject.amount,
                                  expectedRevenue:
                                      _editedProject.expectedRevenue,
                                  closeDate: _editedProject.closeDate,
                                  status: _editedProject.status,
                                );
                              });
                            },
                          ),
                          TextFormField(
                            initialValue: _initValues['amount'].toString(),
                            decoration: InputDecoration(labelText: "Amount"),
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Please provide a value.";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _editedProject = Project(
                                id: _editedProject.id,
                                name: _editedProject.name,
                                accountId: _editedProject.accountId,
                                materials: _editedProject.materials,
                                quotations: _editedProject.quotations,
                                amount: double.parse(value),
                                expectedRevenue: _editedProject.expectedRevenue,
                                closeDate: _editedProject.closeDate,
                                status: _editedProject.status,
                              );
                            },
                          ),
                          TextFormField(
                            initialValue:
                                _initValues['expectedRevenue'].toString(),
                            decoration:
                                InputDecoration(labelText: "Expected Revenue"),
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Please provide a value.";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _editedProject = Project(
                                id: _editedProject.id,
                                name: _editedProject.name,
                                accountId: _editedProject.accountId,
                                materials: _editedProject.materials,
                                quotations: _editedProject.quotations,
                                amount: _editedProject.amount,
                                expectedRevenue: double.parse(value),
                                closeDate: _editedProject.closeDate,
                                status: _editedProject.status,
                              );
                            },
                          ),
                          DateTimeField(
                            initialValue: _editedProject.closeDate,
                            format: DateFormat("MM-dd-yyyy"),
                            onShowPicker: (context, currentValue) {
                              return showDatePicker(
                                  context: context,
                                  firstDate: DateTime(1900),
                                  initialDate: currentValue ?? DateTime.now(),
                                  lastDate: DateTime(2100));
                            },
                            onSaved: (value) {
                              _editedProject = Project(
                                id: _editedProject.id,
                                name: _editedProject.name,
                                accountId: _editedProject.accountId,
                                materials: _editedProject.materials,
                                quotations: _editedProject.quotations,
                                amount: _editedProject.amount,
                                expectedRevenue: _editedProject.expectedRevenue,
                                closeDate: value,
                                status: _editedProject.status,
                              );
                            },
                          ),
                          TextFormField(
                            initialValue: _initValues['status'],
                            decoration: InputDecoration(labelText: "Status"),
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Please provide a value.";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _editedProject = Project(
                                id: _editedProject.id,
                                name: _editedProject.name,
                                accountId: _editedProject.accountId,
                                materials: _editedProject.materials,
                                quotations: _editedProject.quotations,
                                amount: _editedProject.amount,
                                expectedRevenue: _editedProject.expectedRevenue,
                                closeDate: _editedProject.closeDate,
                                status: value,
                              );
                            },
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                RaisedButton(
                                  child: Text("Submit"),
                                  textColor: Colors.white,
                                  color: Theme.of(context).accentColor,
                                  onPressed: () {
                                    _saveForm();
                                  },
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                RaisedButton(
                                  child: Text("Cancel"),
                                  textColor: Colors.white,
                                  color: Theme.of(context).errorColor,
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
