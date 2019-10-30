import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warehouse_management_system/models/material_item.dart';
import 'package:warehouse_management_system/providers/materials.dart';
import 'package:warehouse_management_system/providers/projects.dart';

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
  var quantity;
  final _form = GlobalKey<FormState>();
  var _editedMaterial = MaterialItem(
    id: null,
    name: '',
    amount: 0,
  );

  var _initValues = {
    'name': '',
    'amount': 0.0,
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
          'name': _editedMaterial.name,
          'amount': _editedMaterial.amount,
        };
        quantity = Provider.of<Projects>(context, listen: false)
            .findById(widget.projectId)
            .materials[widget.materialId];
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
    if (_editedMaterial.id != null) {
      await Provider.of<Materials>(context, listen: false)
          .updateMaterial(_editedMaterial);
      await Provider.of<Projects>(context, listen: false)
          .findById(widget.projectId)
          .updateMaterialQuantity(_editedMaterial.id, quantity);
    } else {
      try {
        await Provider.of<Materials>(context, listen: false)
            .addMaterial(_editedMaterial);
        await Provider.of<Projects>(context, listen: false)
            .findById(widget.projectId)
            .addMaterialToProject(_editedMaterial.id, quantity);
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
                          TextFormField(
                            initialValue: _initValues['name'],
                            decoration: InputDecoration(labelText: "Name"),
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
                              );
                            },
                          ),
                          TextFormField(
                            initialValue: quantity.toString(),
                            decoration: InputDecoration(labelText: "Quantity"),
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
