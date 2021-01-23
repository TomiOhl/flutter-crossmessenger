import 'package:flutter/material.dart';
import 'package:kotprog/db/db_access.dart';
import 'package:kotprog/languages/localizations.dart';
import 'package:kotprog/models/chat.dart';
import 'package:provider/provider.dart';

import 'chat_card.dart';

class ChatList extends StatefulWidget {
  ChatList({Key key}) : super(key: key);

  @override
  _ChatListState createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  Future<List<Chat>> chatList;

  void didChangeDependencies() {
    super.didChangeDependencies();
    chatList = Provider.of<DbAccess>(context).loadChats();
  }

  // Ez a metódus a lista elemeit építi fel
  Widget _buildItemWithArgs(BuildContext context, int index, List<Chat> chats) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 10,
      ),
      child:
        ChatCard(
          chat: chats[index],
        ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: FutureBuilder<List<Chat>>(
        future: chatList,
        builder: (BuildContext context, AsyncSnapshot<List<Chat>> snapshot) { // ahol a snapshotban remélhetőleg már a nekem kellő lista van
          Widget child;
          if (snapshot.hasData) {
            child =
              ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) => _buildItemWithArgs(context, index, snapshot.data),
              );
          } else if (snapshot.hasError) {
            child =
              Text(CustomLocalizations.of(context).someError + ": ${snapshot.error}");
          } else {
            child = Text("...");
          }
          return child;
        },
      ),
    );
  }

}