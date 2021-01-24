import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:kotprog/widgets/map.dart';
import 'package:provider/provider.dart';

import 'languages/localizations.dart';
import 'models/profile.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _nick;
  final _formKey = GlobalKey<FormState>();
  final _mapsFormKey = GlobalKey<FormState>();
  TextEditingController _nickController = TextEditingController();
  TextEditingController _latController = TextEditingController();
  TextEditingController _longController = TextEditingController();
  Map map = Map(mapController: new MapController());

  void chooseContact(BuildContext context) async {
    if (await Permission.contacts.request().isGranted) {
      var contact = await Navigator.pushNamed(context, "/choosecontact") as Contact;
      if (contact != null)
        _nickController.text = contact.displayName;
    } else if (await Permission.contacts.isPermanentlyDenied) {
      openAppSettings();
    } else {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content:
            Text(CustomLocalizations.of(context).cannotAccessContacts),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    _nick = Provider.of<Profile>(context).nick;
    return Scaffold(
      appBar: AppBar(
        title: Text(CustomLocalizations.of(context).profile),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView(
          physics: BouncingScrollPhysics(), // iOS-like overscroll animáció
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
                  padding: EdgeInsets.only(top: 20, bottom: 40),
                  child:
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child:
                            TextFormField(
                              controller: _nickController,
                              decoration: InputDecoration(
                                labelText: CustomLocalizations.of(context).changeNick,
                              ),
                              validator: (value) {
                                if (value.trim().isEmpty) {
                                  return CustomLocalizations.of(context).fieldEmpty;
                                }
                                return null;
                              },
                              maxLines: 1,
                              textInputAction: TextInputAction.done,
                              textCapitalization: TextCapitalization.words,
                            ),
                        ),
                        Builder(  // Builderbe wrappelve, hogy más legyen a context, így lehessen snackbart megjeleníteni
                          builder: (context) =>
                              IconButton(
                                icon: Icon(
                                  Icons.person_add,
                                  color: Theme.of(context).accentColor,
                                ),
                                tooltip: CustomLocalizations.of(context).chooseContact,
                                onPressed: () {
                                  chooseContact(context);
                                },
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
                          child: Text(CustomLocalizations.of(context).modify),
                        ),
                      ],
                    ),
                ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child:
                Text(
                  CustomLocalizations.of(context).map,
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
            ),
            Form(
              key: _mapsFormKey,
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
                        controller: _latController,
                        decoration: InputDecoration(
                          labelText: CustomLocalizations.of(context).latitude,
                        ),
                        validator: (value) {
                          if (value.trim().isEmpty) {
                            return CustomLocalizations.of(context).fieldEmpty;
                          }
                          return null;
                        },
                        maxLines: 1,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    Expanded(
                      child:
                      TextFormField(
                        controller: _longController,
                        decoration: InputDecoration(
                          labelText: CustomLocalizations.of(context).longitude,
                        ),
                        validator: (value) {
                          if (value.trim().isEmpty) {
                            return CustomLocalizations.of(context).fieldEmpty;
                          }
                          return null;
                        },
                        maxLines: 1,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    RaisedButton(
                      onPressed: () {
                        if (_mapsFormKey.currentState.validate()) {
                          setState(() {
                            // Elnavigál az új helyre, majd frissíti az állapotot
                            map.updateLocation(double.parse(_latController.value.text), double.parse(_longController.value.text));
                          });
                        }
                      },
                      color: Theme.of(context).accentColor,
                      textColor: Colors.white,
                      child: Text(CustomLocalizations.of(context).modify),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.36,
              child: map,
            )
          ],
        ),
      ),
    );
  }
}