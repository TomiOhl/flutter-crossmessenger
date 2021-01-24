import 'package:flutter/material.dart';

class ParticipantsCard extends StatelessWidget {
  final String name;

  const ParticipantsCard({Key key,  @required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell( // ez azért kell, mert van onTapja, illetve ripple-t jelenít meg a GestureDetectorral ellentétben
      onTap: () {},
      customBorder: RoundedRectangleBorder( // hogy a ripple kerek legyen
        borderRadius: BorderRadius.circular(20),
      ),
      child: Ink( // itt pedig a sima container színe eltakarná a ripple-t, ez viszont megjeleníti a tetején
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all( //hogy a látható widget kerek legyen
            Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.3),
              spreadRadius: -5,
              offset: Offset(-2, -2),
              blurRadius: 3,
            ),
            BoxShadow(
              color: Colors.grey[900].withOpacity(0.1),
              spreadRadius: 2,
              offset: Offset(2, 2),
              blurRadius: 5,
            ),
          ],
        ),
        child:
          Text(
            name,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
      ),
    );
  }
}