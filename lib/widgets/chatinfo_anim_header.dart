import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class ChatInfoAnimatedHeader extends AnimatedWidget {
  final String text;

  ChatInfoAnimatedHeader({Key key, Animation<Color> animation, @required this.text})
      : super(key: key, listenable: animation);

  Widget build(BuildContext context) {
    final animation = listenable as Animation<Color>;
    return Text(
      text,
      style: TextStyle(
        color: animation.value,
        fontWeight: FontWeight.bold,
        fontSize: 42,
      ),
    );
  }
}