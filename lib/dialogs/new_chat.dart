// Manages the chat creation
import 'package:flutter/material.dart';
import 'package:kotprog/db/db_access.dart';
import 'package:kotprog/languages/localizations.dart';
import 'package:kotprog/models/chat.dart';
import 'package:provider/provider.dart';

import 'new_chat_form.dart';

class NewChatButton extends StatelessWidget {
  final Function onChatCreated;

  NewChatButton({Key key, @required this.onChatCreated}) : super(key: key);

  Future<void> _newChat(BuildContext context) async {
    var chat = await showDialog<Chat>(
      context: context,
      builder: (BuildContext context) => NewChatFormDialog(),
    );
    if (chat != null) {
      var dbAccess = context.read<DbAccess>();
      // Save the address into the DB
      await dbAccess.addChat(chat);
      // Call the callback
      await onChatCreated();
      // Show info to the user
      Scaffold.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(CustomLocalizations.of(context).chatCreated),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        _newChat(context);
      },
      child: Icon(Icons.add),
    );
  }
}