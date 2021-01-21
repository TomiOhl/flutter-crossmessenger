import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/profile.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _nick;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nickController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _nick = Provider.of<Profile>(context).nick;
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Text(
              "<!-- TODO: profilkép és módosítás gomb -->"
            ),
            Text(
              _nick,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 42,
              ),
            ),
            Form(
              key: _formKey,
              child:
                Container(
                  padding: EdgeInsets.only(top: 20, bottom: 20),
                  child:
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child:
                            TextFormField(
                              controller: _nickController,
                              decoration: InputDecoration(
                                labelText: "Profilnév módosítása",
                              ),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "A mező nem lehet üres";
                                }
                                return null;
                              },
                              maxLines: 1,
                              textInputAction: TextInputAction.done,
                              textCapitalization: TextCapitalization.words,
                            ),
                        ),
                        RaisedButton(
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              setState(() {
                                // Elmenti az új nevet, majd frissíti az állapotot
                                Provider.of<Profile>(context, listen: false).nick = _nickController.value.text;
                              });
                            }
                          },
                          color: Theme.of(context).accentColor,
                          textColor: Colors.white,
                          child: Text("Módosítás"),
                        ),
                      ],
                    ),
                ),
            ),
          ],
        ),
      ),
    );
  }
}