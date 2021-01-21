import 'package:flutter/material.dart';
import 'package:kotprog/languages/localizations.dart';

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
        child: Text(CustomLocalizations.of(context).createNewChat),
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
                  labelText: CustomLocalizations.of(context).name,
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return CustomLocalizations.of(context).fieldEmpty;
                  }
                  return null;
                },
                textCapitalization: TextCapitalization.sentences,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(CustomLocalizations.of(context).cancel),
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
                    child: Text(CustomLocalizations.of(context).create),
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