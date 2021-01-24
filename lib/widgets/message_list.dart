import 'package:flutter/material.dart';
import 'package:kotprog/db/db_access.dart';
import 'package:kotprog/languages/localizations.dart';
import 'package:kotprog/models/message.dart';
import 'package:provider/provider.dart';

import 'message_card.dart';

class MessageList extends StatefulWidget {
  final int chatId;

  MessageList({Key key, @required this.chatId}) : super(key: key);

  @override
  _MessageListState createState() => _MessageListState();
}

class _MessageListState extends State<MessageList> {
  Future<List<Message>> messageList;

  void didChangeDependencies() {
    super.didChangeDependencies();
    messageList = Provider.of<DbAccess>(context).loadMessages(widget.chatId);
  }

  // Ez a metódus a lista elemeit építi fel
  Widget _buildItemWithArgs(BuildContext context, int index, List<Message> msgs) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 10,
      ),
      child:
        MessageCard(
          message: msgs[index],
        ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: FutureBuilder<List<Message>>(
        future: messageList,
        builder: (BuildContext context, AsyncSnapshot<List<Message>> snapshot) { // ahol a snapshotban remélhetőleg már a nekem kellő lista van
          Widget child;
          if (snapshot.hasData) {
            child =
                ListView.builder(
                  physics: BouncingScrollPhysics(), // iOS-like overscroll animáció
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) => _buildItemWithArgs(context, index, snapshot.data),
                );
          } else if (snapshot.hasError) {
            child =
                Text(CustomLocalizations.of(context).someError + ": ${snapshot.error}");
          } else {
            child = Center(child: CircularProgressIndicator());
          }
          return child;
        },
      ),
      );
  }

}