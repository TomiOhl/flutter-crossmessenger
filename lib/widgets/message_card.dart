import 'package:flutter/material.dart';
import 'package:kotprog/languages/localizations.dart';
import 'package:kotprog/models/message.dart';

class MessageCard extends StatelessWidget {
  final Message message;
  final EdgeInsetsGeometry padding;

  const MessageCard({Key key, this.message, this.padding}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell( // ez azért kell, mert van onTapja, illetve ripple-t jelenít meg a GestureDetectorral ellentétben
      onTap: () {
        showDetailsDialog(context);
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
              blurRadius: 3,
            ),
            BoxShadow(
              color: Colors.grey[900].withOpacity(0.1),
              spreadRadius: 1,
              offset: Offset(3, 3),
              blurRadius: 3,
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              alignment: AlignmentDirectional.topStart,
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

showDetailsDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(CustomLocalizations.of(context).details),
        content: Text("We need proper db for this."),
        actions: [
          FlatButton(
            child: Text(CustomLocalizations.of(context).ok),
            textColor: Theme.of(context).accentColor,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}