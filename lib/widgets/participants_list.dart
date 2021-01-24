import 'package:flutter/material.dart';
import 'package:kotprog/db/db_access.dart';
import 'package:kotprog/languages/localizations.dart';
import 'package:kotprog/widgets/participants_card.dart';
import 'package:provider/provider.dart';

class ParticipantsList extends StatefulWidget {
  final int chatId;

  ParticipantsList({Key key, @required this.chatId}) : super(key: key);

  @override
  _ParticipantsListState createState() => _ParticipantsListState();
}

class _ParticipantsListState extends State<ParticipantsList> {
  Future<List<String>> participantsList;

  void didChangeDependencies() {
    super.didChangeDependencies();
    participantsList = Provider.of<DbAccess>(context).loadChaParticipants(widget.chatId);
  }

  // Ez a metódus a lista elemeit építi fel
  Widget _buildItemWithArgs(BuildContext context, int index, List<String> participants) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 6,
        horizontal: 10,
      ),
      child:
        ParticipantsCard(name: participants[index]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: FutureBuilder<List<String>>(
        future: participantsList,
        builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) { // ahol a snapshotban remélhetőleg már a nekem kellő lista van
          Widget child;
          if (snapshot.hasData) {
            child =
                ListView.builder(
                  physics: BouncingScrollPhysics(), // iOS-like overscroll animáció
                  shrinkWrap: true,
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) => _buildItemWithArgs(context, index, snapshot.data),
                );
          } else if (snapshot.hasError) {
            child =
                Text(CustomLocalizations.of(context).someError + ": ${snapshot.error}");
          } else {
            child = Text("...");
          }
          return child;
        },
      ),
    );
  }

}