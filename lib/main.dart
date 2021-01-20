import 'package:flutter/material.dart';
import 'package:kotprog/dialogs/new_chat.dart';
import 'package:kotprog/profile_screen.dart';
import 'package:kotprog/widgets/chat_list.dart';
import 'package:provider/provider.dart';

import 'chat_screen.dart';
import 'models/profile.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => Profile(),
      child: MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CrossMessenger',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        accentColor: Colors.redAccent,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => MyHomePage(title: "CrossMessenger"),
        "/chat": (context) => ChatPage(),
        "/profile": (context) => ProfilePage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful
  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.person,
              color: Colors.white,
            ),
            tooltip: "Profil",
            onPressed: () {
              Navigator.of(context).pushNamed("/profile");
            },
          )
        ],
      ),
      body: Container(
        child: ChatList(),
      ),
      floatingActionButton:
        new NewChatButton(onChatCreated: null),
    );
  }
}