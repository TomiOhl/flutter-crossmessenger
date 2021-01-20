import 'package:flutter/material.dart';
import 'package:kotprog/models/message.dart';

import 'message_card.dart';

class MessageList extends StatelessWidget {

  // Ez a metódus a lista elemeit építi fel. Az elemek az MSGS listában találhatók.
  Widget _buildItem(BuildContext context, int index) {
    var message = MSGS[index];
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 10,
      ),
      height: 100,
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              child: MessageCard(
                message: MSGS[index],
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
              itemCount: MSGS.length,
              itemBuilder: _buildItem,
            ),
      );
  }

}