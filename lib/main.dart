import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:kotprog/dialogs/new_chat.dart';
import 'package:kotprog/profile_screen.dart';
import 'package:kotprog/widgets/chat_list.dart';
import 'package:provider/provider.dart';

import 'chat_info_screen.dart';
import 'chat_screen.dart';
import 'db/db_access.dart';
import 'db/sql.dart';
import 'languages/localizations.dart';
import 'models/profile.dart';

void main() {
  final sql = Sql();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Profile(),
        ),
        Provider(
          create: (_) => DbAccess(sql: sql),
        ),
      ],
      child: MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "CrossMessenger",
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        accentColor: Colors.redAccent,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => MyHomePage(title: CustomLocalizations.of(context).appName),
        "/chat": (context) => ChatPage(),
        "/profile": (context) => ProfilePage(),
        "/chatinfo": (context) => ChatInfoPage(),
      },
      localizationsDelegates: [
        CustomLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', ''),
        const Locale('hu', ''),
      ],
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
              Icons.person_outline,
              color: Colors.white,
            ),
            tooltip: CustomLocalizations.of(context).profile,
            onPressed: () {
              Navigator.of(context).pushNamed("/profile");
            },
          )
        ],
      ),
      body: Container(
        key: UniqueKey(),
        child: ChatList(),
      ),
      floatingActionButton:
        new NewChatButton(onChatCreated: () => setState((){}) ),
    );
  }
}
