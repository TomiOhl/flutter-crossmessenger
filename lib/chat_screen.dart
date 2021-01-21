import 'package:flutter/material.dart';
import 'package:kotprog/widgets/message_list.dart';
import 'package:provider/provider.dart';

import 'models/profile.dart';

class ChatPage extends StatefulWidget {
  ChatPage({Key key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _newMsgController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ModalRoute.of(context).settings.arguments),
      ),
      body:
          Column(
            children: [
              Expanded(
                child: MessageList(),
              ),

              //asd
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
                            labelText: "Üzenet írása mint " + Provider.of<Profile>(context).nick,
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return "A mező nem lehet üres";
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
                            tooltip: "Küldés",
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                setState(() {
                                  // Elsendeli a message-t, majd frissíti az állapotot
                                });
                              }
                            },
                          ),
                      ),
                    ],
                  ),
                ),
              ),
              //asd
            ],
          ),
    );
  }
}