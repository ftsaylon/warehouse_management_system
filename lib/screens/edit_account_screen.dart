import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/account.dart';
import '../providers/accounts.dart';

class EditAccountScreen extends StatefulWidget {
  static const routeName = "/edit-account";
  @override
  _EditAccountScreenState createState() => _EditAccountScreenState();
}

class _EditAccountScreenState extends State<EditAccountScreen> {
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
    contacts: [],
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
      final accountId = ModalRoute.of(context).settings.arguments as String;
      if (accountId != null) {
        _editedAccount =
            Provider.of<Accounts>(context, listen: false).findById(accountId);
        _initValues = {
          'name': _editedAccount.name,
          'category': _editedAccount.category,
          'website': _editedAccount.website,
          'industry': _editedAccount.industry,
          'contactNumber': _editedAccount.contactNumber,
          'address': _editedAccount.address,
          'contacts': _editedAccount.contacts,
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
    if (_editedAccount.id != null) {
      await Provider.of<Accounts>(context, listen: false)
          .updateAccount(_editedAccount.id, _editedAccount);
    } else {
      try {
        await Provider.of<Accounts>(context, listen: false)
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
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Form(
          key: _form,
          child: ListView(
            children: <Widget>[
              TextFormField(
                initialValue: _initValues['name'],
                decoration: InputDecoration(labelText: "Name"),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_categoryFocusNode);
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
                    contacts: _editedAccount.contacts,
                  );
                },
              ),
              TextFormField(
                initialValue: _initValues['category'],
                decoration: InputDecoration(labelText: "Category"),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_websiteFocusNode);
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
                    contacts: _editedAccount.contacts,
                  );
                },
              ),
              TextFormField(
                initialValue: _initValues['website'],
                decoration: InputDecoration(labelText: "Website"),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_industryFocusNode);
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
                    contacts: _editedAccount.contacts,
                  );
                },
              ),
              TextFormField(
                initialValue: _initValues['industry'],
                decoration: InputDecoration(labelText: "Industry"),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_contactNumberFocusNode);
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
                    contacts: _editedAccount.contacts,
                  );
                },
              ),
              TextFormField(
                initialValue: _initValues['contactNumber'],
                decoration: InputDecoration(labelText: "Contact Number"),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_addressFocusNode);
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
                    contacts: _editedAccount.contacts,
                  );
                },
              ),
              TextFormField(
                initialValue: _initValues['address'],
                decoration: InputDecoration(labelText: "Address"),
                textInputAction: TextInputAction.next,
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
                    contacts: _editedAccount.contacts,
                  );
                },
              ),
              RaisedButton(
                child: Text("Submit"),
                onPressed: () {
                  _saveForm();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
