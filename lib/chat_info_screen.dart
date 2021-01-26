import 'package:flutter/material.dart';
import 'package:kotprog/widgets/chatinfo_anim_header.dart';
import 'package:kotprog/widgets/participants_list.dart';

import 'languages/localizations.dart';
import 'models/chat.dart';

class ChatInfoPage extends StatefulWidget {
  ChatInfoPage({Key key}) : super(key: key);

  @override
  _ChatInfoPageState createState() => _ChatInfoPageState();
}

class _ChatInfoPageState extends State<ChatInfoPage> with SingleTickerProviderStateMixin {
  Chat chat;
  Animation<Color> colorAnimation;
  AnimationController controller;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    controller = AnimationController(duration: const Duration(seconds: 3), vsync: this);
    colorAnimation = ColorTween(begin: Theme.of(context).accentColor, end: Colors.black).animate(controller);
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    chat = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(CustomLocalizations.of(context).details),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView(
          physics: BouncingScrollPhysics(), // iOS-like overscroll animáció
          children: <Widget>[
            ChatInfoAnimatedHeader(animation: colorAnimation, text: chat.title),
            Text(
              CustomLocalizations.of(context).participants,
              style: TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 28,
                color: Colors.grey,
              ),
            ),
            ParticipantsList(chatId: chat.id),
          ],
        ),
      ),
    );
  }
}