import 'package:flutter/material.dart';
import 'package:kotprog/models/chat.dart';

import 'chat_card.dart';

class ChatList extends StatelessWidget {

  // Ez a metódus a lista elemeit építi fel. Az elemek az MSGS listában találhatók.
  Widget _buildItem(BuildContext context, int index) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 10,
      ),
      height: 100,
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              child: ChatCard(
                chat: CHATS[index],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: ListView.builder(
        itemCount: CHATS.length,
        itemBuilder: _buildItem,
      ),
    );
  }

}