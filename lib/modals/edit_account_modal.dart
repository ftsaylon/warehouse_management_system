// Author: Saylon, Francis T.
// Project Name: Solar Warehouse Management System

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/account.dart';
import '../providers/accounts.dart';

class EditAccountModal extends StatefulWidget {
  final String accountId; // Gets accountId if editing. accountId is null if adding.

  EditAccountModal({this.accountId});

  @override
  _EditAccountModalState createState() => _EditAccountModalState();
}

class _EditAccountModalState extends State<EditAccountModal> {
  final _categoryFocusNode = FocusNode();
  final _websiteFocusNode = FocusNode();
  final _industryFocusNode = FocusNode();
  final _contactNumberFocusNode = FocusNode();
  final _addressFocusNode = FocusNode();

  final _form = GlobalKey<FormState>();
  var _editedAccount = Account(
    id: null,
    name: "",
    category: "",
    website: "",
    industry: "",
    contactNumber: "",
    address: "",
  );
  var _initValues = {
    'name': '',
    'category': '',
    'website': '',
    'industry': '',
    'contactNumber': '',
    'address': '',
    'contacts': [],
  };
  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      if (widget.accountId != null) {
        _editedAccount = Provider.of<Accounts>(context, listen: false)
            .findById(widget.accountId);
        _initValues = {
          'name': _editedAccount.name,
          'category': _editedAccount.category,
          'website': _editedAccount.website,
          'industry': _editedAccount.industry,
          'contactNumber': _editedAccount.contactNumber,
          'address': _editedAccount.address,
        };
      }
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _categoryFocusNode.dispose();
    _websiteFocusNode.dispose();
    _industryFocusNode.dispose();
    _contactNumberFocusNode.dispose();
    _addressFocusNode.dispose();
    super.dispose();
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
    if (_editedAccount.id != null) { // Checks if editing or adding
      await Provider.of<Accounts>(context, listen: false) // Runs when editing the account
          .updateAccount(_editedAccount);
    } else {
      try {
        await Provider.of<Accounts>(context, listen: false) // Runs when adding a new account
            .addAccount(_editedAccount);
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
                  _editedAccount.id != null
                      ? Text(
                          "Edit Account",
                          style: Theme.of(context).textTheme.headline,
                        )
                      : Text(
                          "Add Account",
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
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (_) {
                              FocusScope.of(context)
                                  .requestFocus(_categoryFocusNode);
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Please provide a value.";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _editedAccount = Account(
                                id: _editedAccount.id,
                                name: value,
                                category: _editedAccount.category,
                                website: _editedAccount.website,
                                industry: _editedAccount.industry,
                                contactNumber: _editedAccount.contactNumber,
                                address: _editedAccount.address,
                              );
                            },
                          ),
                          TextFormField(
                            initialValue: _initValues['category'],
                            decoration: InputDecoration(labelText: "Category"),
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (_) {
                              FocusScope.of(context)
                                  .requestFocus(_websiteFocusNode);
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Please provide a value.";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _editedAccount = Account(
                                id: _editedAccount.id,
                                name: _editedAccount.name,
                                category: value,
                                website: _editedAccount.website,
                                industry: _editedAccount.industry,
                                contactNumber: _editedAccount.contactNumber,
                                address: _editedAccount.address,
                              );
                            },
                          ),
                          TextFormField(
                            initialValue: _initValues['website'],
                            decoration: InputDecoration(labelText: "Website"),
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (_) {
                              FocusScope.of(context)
                                  .requestFocus(_industryFocusNode);
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Please provide a value.";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _editedAccount = Account(
                                id: _editedAccount.id,
                                name: _editedAccount.name,
                                category: _editedAccount.category,
                                website: value,
                                industry: _editedAccount.industry,
                                contactNumber: _editedAccount.contactNumber,
                                address: _editedAccount.address,
                              );
                            },
                          ),
                          TextFormField(
                            initialValue: _initValues['industry'],
                            decoration: InputDecoration(labelText: "Industry"),
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (_) {
                              FocusScope.of(context)
                                  .requestFocus(_contactNumberFocusNode);
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Please provide a value.";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _editedAccount = Account(
                                id: _editedAccount.id,
                                name: _editedAccount.name,
                                category: _editedAccount.category,
                                website: _editedAccount.website,
                                industry: value,
                                contactNumber: _editedAccount.contactNumber,
                                address: _editedAccount.address,
                              );
                            },
                          ),
                          TextFormField(
                            initialValue: _initValues['contactNumber'],
                            decoration:
                                InputDecoration(labelText: "Contact Number"),
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (_) {
                              FocusScope.of(context)
                                  .requestFocus(_addressFocusNode);
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Please provide a value.";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _editedAccount = Account(
                                id: _editedAccount.id,
                                name: _editedAccount.name,
                                category: _editedAccount.category,
                                website: _editedAccount.website,
                                industry: _editedAccount.industry,
                                contactNumber: value,
                                address: _editedAccount.address,
                              );
                            },
                          ),
                          TextFormField(
                            initialValue: _initValues['address'],
                            decoration: InputDecoration(labelText: "Address"),
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (_) {
                              _saveForm();
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Please provide a value.";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _editedAccount = Account(
                                id: _editedAccount.id,
                                name: _editedAccount.name,
                                category: _editedAccount.category,
                                website: _editedAccount.website,
                                industry: _editedAccount.industry,
                                contactNumber: _editedAccount.contactNumber,
                                address: value,
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
