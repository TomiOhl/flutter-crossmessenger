import 'package:flutter/material.dart';

class Profile with ChangeNotifier {
  String _nick = "";

  String get nick => _nick;
  set nick(newNick) => _nick = newNick;
}