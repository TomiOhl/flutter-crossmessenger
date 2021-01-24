import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:kotprog/languages/localizations.dart';

class ContactChooserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(CustomLocalizations.of(context).chooseContact),
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(10),
        child: FutureBuilder<Iterable<Contact>>(
            future: ContactsService.getContacts(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return ListView(
                  physics: BouncingScrollPhysics(), // iOS-like overscroll animáció
                  children: snapshot.data.map((contact) {
                    return ListTile(
                      title: Text(contact.displayName),
                      onTap: () {
                        Navigator.pop(context, contact);
                      },
                    );
                  }).toList(),
                );
              }
              return Center(child: CircularProgressIndicator());
            }),
      ),
    );
  }
}