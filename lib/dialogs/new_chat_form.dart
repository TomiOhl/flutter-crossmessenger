import 'package:flutter/material.dart';

class NewChatFormDialog extends StatefulWidget {
  @override
  _NewChatFormDialogState createState() => _NewChatFormDialogState();
}

class _NewChatFormDialogState extends State<NewChatFormDialog> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Creates a dialog
    return SimpleDialog(
      title: Container(
        child: Text("Új chat létrehozása"),
        alignment: Alignment.center,
      ),
      contentPadding: EdgeInsets.all(10),
      children: <Widget>[
        Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: "Név",
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return "A mező nem lehet üres";
                  }
                  return null;
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Mégse"),
                  ),
                  FlatButton(
                    onPressed: () {
                       if (_formKey.currentState.validate()) {
                         Navigator.of(context).pop(
                          // Chat(title: _titleController.value.text),
                         );
                       }
                    },
                    textColor: Theme.of(context).accentColor,
                    child: Text("Létrehozás"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}