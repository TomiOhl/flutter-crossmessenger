// Manages the chat creation
import 'package:flutter/material.dart';
import 'package:kotprog/models/chat.dart';

import 'new_chat_form.dart';

class NewChatButton extends StatelessWidget {
  final Function onChatCreated;

  NewChatButton({Key key, @required this.onChatCreated}) : super(key: key);

  Future<void> _newChat(BuildContext context) async {
    var address = await showDialog<Chat>(
      context: context,
      builder: (BuildContext context) => NewChatFormDialog(),
    );
    if (address != null) {
      // Get the repository through Provider
      //var repository = context.read<ProfileRepository>();
      // Save the address into the DB
      //await repository.addAddress(address);
      // Call the callback
      await onChatCreated();
      // Show info to the user
      Scaffold.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text("Chat létrehozva"),
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