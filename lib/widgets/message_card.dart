import 'package:flutter/material.dart';
import 'package:kotprog/models/message.dart';

class MessageCard extends StatelessWidget {
  final Message message;
  final EdgeInsetsGeometry padding;

  const MessageCard({Key key, this.message, this.padding}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell( // ez azért kell, mert van onTapja, illetve ripple-t jelenít meg a GestureDetectorral ellentétben
      onTap: () {
        Navigator.pushNamed(context, "/chat");  //TODO: maybe profile details?
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
              blurRadius: 20,
            ),
            BoxShadow(
              color: Colors.grey[900].withOpacity(0.3),
              spreadRadius: 2,
              offset: Offset(7, 7),
              blurRadius: 15,
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: padding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message.sender,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      message.content,
                      style: TextStyle(
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}