import 'package:flutter/material.dart';
import 'package:kotprog/widgets/message_list.dart';
import 'package:provider/provider.dart';

import 'db/db_access.dart';
import 'languages/localizations.dart';
import 'models/chat.dart';
import 'models/message.dart';
import 'models/profile.dart';

class ChatPage extends StatefulWidget {
  ChatPage({Key key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _newMsgController = TextEditingController();
  Chat chat;

  // Elsendeli a message-t, majd frissíti az állapotot
  void _sendMessage() async {
    if (_formKey.currentState.validate()) {
      var msg = Message(
          chatId: chat.id,
          sender: Provider.of<Profile>(context, listen: false).nick,
          content: _newMsgController.value.text,
          timestamp: DateTime.now().toString()
      );
      if (msg != null) {
        var dbAccess = context.read<DbAccess>();
        // Save the address into the DB
        await dbAccess.addMessage(msg);
        setState((){
          _newMsgController.clear();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    chat = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(chat.title),
      ),
      body:
          Column(
            children: [
              Expanded(
                key: UniqueKey(),
                child: MessageList(chatId: chat.id),
              ),
              Form(
                key: _formKey,
                child:
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(10),
                  child:
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child:
                        TextFormField(
                          controller: _newMsgController,
                          decoration: InputDecoration(
                            labelText: CustomLocalizations.of(context).newMessageAs + " " + Provider.of<Profile>(context).nick,
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return CustomLocalizations.of(context).fieldEmpty;
                            }
                            return null;
                          },
                          maxLines: null,
                          textCapitalization: TextCapitalization.sentences,
                        ),
                      ),
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Theme.of(context).accentColor,
                        child:
                          IconButton(
                            icon: Icon(
                              Icons.send,
                              color: Colors.white,
                            ),
                            tooltip: CustomLocalizations.of(context).send,
                            onPressed: _sendMessage,
                          ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
    );
  }
}