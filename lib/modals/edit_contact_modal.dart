// Author: Saylon, Francis T.
// Project Name: Solar Warehouse Management System

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:warehouse_management_system/providers/accounts.dart';

import '../models/contact.dart';
import '../providers/contacts.dart';

class EditContactModal extends StatefulWidget {
  final String contactId;
  final String accountId;

  EditContactModal({this.contactId, this.accountId});

  @override
  _EditContactModalState createState() => _EditContactModalState();
}

class _EditContactModalState extends State<EditContactModal> {
  final _form = GlobalKey<FormState>();
  var _editedContact = Contact(
    id: null,
    name: '',
    contactNumber: '',
    accountId: null,
  );
  var _isInit = true;
  var _isLoading = false;
  var _initValues = {
    'name': '',
    'contactNumber': '',
    'accountId': '',
  };

  @override
  void didChangeDependencies() {
    if (_isInit) {
      if (widget.contactId != null) {
        _editedContact = Provider.of<Contacts>(context, listen: false)
            .findById(widget.contactId);
        _initValues = {
          'name': _editedContact.name,
          'contactNumber': _editedContact.contactNumber,
          'accountId': widget.accountId ?? _editedContact.accountId,
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
    if (_editedContact.id != null) {
      await Provider.of<Contacts>(context, listen: false)
          .updateContact(_editedContact);
    } else {
      try {
        await Provider.of<Contacts>(context, listen: false)
            .addContact(_editedContact);
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
    // var accountChoices = Provider.of<Accounts>(context).items.map(
    //   (item) {
    //     return DropdownMenuItem<String>(
    //       value: item.id,
    //       child: Text(item.name),
    //     );
    //   },
    // ).toList();

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
                  _editedContact.id != null
                      ? Text(
                          "Edit Contact",
                          style: Theme.of(context).textTheme.headline,
                        )
                      : Text(
                          "Add Contact",
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
                                return "Please provide a value";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _editedContact = Contact(
                                id: _editedContact.id,
                                name: value,
                                contactNumber: _editedContact.contactNumber,
                                accountId: widget.accountId ??
                                    _editedContact.accountId,
                              );
                            },
                          ),
                          TextFormField(
                            initialValue: _initValues['contactNumber'],
                            decoration:
                                InputDecoration(labelText: "Contact Number"),
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Please provide a value";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _editedContact = Contact(
                                id: _editedContact.id,
                                name: _editedContact.name,
                                contactNumber: value,
                                accountId: widget.accountId ??
                                    _editedContact.accountId,
                              );
                            },
                          ),
                          // DropdownButtonFormField(
                          //   items: accountChoices,
                          //   value: _editedContact.accountId,
                          //   decoration: InputDecoration(labelText: "Account"),
                          //   validator: (value) {
                          //     if (value.isEmpty) {
                          //       return "Please provide a value.";
                          //     }
                          //     return null;
                          //   },
                          //   onChanged: (value) {
                          //     setState(() {
                          //       _editedContact = Contact(
                          //         id: _editedContact.id,
                          //         name: _editedContact.name,
                          //         contactNumber: _editedContact.contactNumber,
                          //         accountId: value,
                          //       );
                          //     });
                          //   },
                          // ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                RaisedButton(
                                  child: Text("Submit"),
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
