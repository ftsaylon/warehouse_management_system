import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

import '../models/material_item.dart';
import '../providers/materials.dart';
import '../providers/projects.dart';

class EditMaterialModal extends StatefulWidget {
  final String materialId;
  final String projectId;

  EditMaterialModal({
    this.materialId,
    this.projectId,
  });

  @override
  _EditMaterialModalState createState() => _EditMaterialModalState();
}

class _EditMaterialModalState extends State<EditMaterialModal> {
  var quantity = 0;
  final _form = GlobalKey<FormState>();
  var _editedMaterial = MaterialItem(
    id: null,
    name: '',
    amount: null,
    stock: null,
  );

  var _initValues = {
    'name': '',
    'amount': 0.0,
    'stock': 0,
  };

  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      if (widget.materialId != null) {
        _editedMaterial = Provider.of<Materials>(context, listen: false)
            .findById(widget.materialId);
        _initValues = {
          'id': _editedMaterial.id,
          'name': _editedMaterial.name,
          'amount': _editedMaterial.amount,
          'stock': _editedMaterial.stock,
        };
        if (widget.projectId != null) {
          quantity = Provider.of<Projects>(context, listen: false)
              .findById(widget.projectId)
              .materials[widget.materialId];
        }
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

    if (widget.projectId != null) {
      if (_editedMaterial.id != null) {
        await Provider.of<Projects>(context, listen: false)
            .updateMaterialInProject(
          widget.projectId,
          _editedMaterial.id,
          quantity,
        );
      }
    } else {
      if (_editedMaterial.id != null) {
        await Provider.of<Materials>(context, listen: false)
            .updateMaterial(_editedMaterial);
      } else {
        await Provider.of<Materials>(context, listen: false)
            .addMaterial(_editedMaterial);
      }
    }
    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    var materialChoices = Provider.of<Materials>(context).items.map(
      (item) {
        return DropdownMenuItem(
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
                  _editedMaterial.id != null
                      ? Text(
                          "Edit Material",
                          style: Theme.of(context).textTheme.headline,
                        )
                      : Text(
                          "Add Material",
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
                          if (widget.projectId == null)
                            TextFormField(
                              initialValue: _initValues['name'].toString(),
                              decoration:
                                  InputDecoration(labelText: "Item Name"),
                              textInputAction: TextInputAction.next,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "Please provide a value.";
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _editedMaterial = MaterialItem(
                                  id: _editedMaterial.id,
                                  name: value,
                                  amount: _editedMaterial.amount,
                                  stock: _editedMaterial.stock,
                                );
                              },
                            ),
                          if (widget.projectId != null)
                            DropdownButtonFormField(
                              items: materialChoices,
                              value: _editedMaterial.id,
                              decoration:
                                  InputDecoration(labelText: "Item Name"),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "Please provide a value";
                                }
                                return null;
                              },
                              onChanged: (value) {
                                setState(() {
                                  _editedMaterial = MaterialItem(
                                    id: value,
                                    name: _editedMaterial.name,
                                    amount: _editedMaterial.amount,
                                    stock: _editedMaterial.stock,
                                  );
                                });
                              },
                            ),
                          if (widget.projectId != null)
                            TextFormField(
                              initialValue: quantity.toString(),
                              decoration:
                                  InputDecoration(labelText: "Quantity"),
                              textInputAction: TextInputAction.next,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "Please provide a value.";
                                }
                                return null;
                              },
                              onSaved: (value) {
                                quantity = int.parse(value);
                              },
                            ),
                          if (widget.projectId == null)
                            TextFormField(
                              initialValue: _initValues['stock'].toString(),
                              decoration: InputDecoration(labelText: "Stocks"),
                              textInputAction: TextInputAction.next,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "Please provide a value.";
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _editedMaterial = MaterialItem(
                                  id: _editedMaterial.id,
                                  name: _editedMaterial.name,
                                  amount: _editedMaterial.amount,
                                  stock: int.parse(value),
                                );
                              },
                            ),
                          if (widget.projectId == null)
                            TextFormField(
                              initialValue: _initValues['amount'].toString(),
                              decoration: InputDecoration(labelText: "Amount"),
                              textInputAction: TextInputAction.next,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "Please provide a value.";
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _editedMaterial = MaterialItem(
                                  id: _editedMaterial.id,
                                  name: _editedMaterial.name,
                                  amount: double.parse(value),
                                  stock: _editedMaterial.stock,
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
