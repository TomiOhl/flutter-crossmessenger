import 'package:flutter/material.dart';
import 'package:kotprog/models/chat.dart';

class ChatCard extends StatelessWidget {
  final Chat chat;
  final EdgeInsetsGeometry padding;

  const ChatCard({Key key, this.chat, this.padding}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell( // ez azért kell, mert van onTapja, illetve ripple-t jelenít meg a GestureDetectorral ellentétben
      onTap: () {
        Navigator.pushNamed(context, "/chat", arguments: chat.title);
      },
      child: Ink( // itt pedig a sima container színe eltakarná a ripple-t, ez viszont megjeleníti a tetején
        height: 130,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.5),
              spreadRadius: -5,
              offset: Offset(-5, -5),
              blurRadius: 7,
            ),
            BoxShadow(
              color: Colors.grey[900].withOpacity(0.2),
              spreadRadius: 2,
              offset: Offset(5, 5),
              blurRadius: 10,
            ),
          ],
        ),
        child:
            Container(
              padding: padding,
              child: Center(
                child:
                  Text(
                    chat.title,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
              ),
            ),
      ),
    );
  }
}