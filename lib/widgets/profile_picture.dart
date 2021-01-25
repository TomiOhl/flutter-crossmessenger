import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kotprog/languages/localizations.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class ProfilePicture extends StatefulWidget {
  @override
  _ProfilePictureState createState() => _ProfilePictureState();
}

class _ProfilePictureState extends State<ProfilePicture> {
  File image;

  @override
  void initState() {
    super.initState();
    initImage();
  }

  Future<void> initImage() async {
    final path = join(
      (await getApplicationDocumentsDirectory()).path, 'dp.png');
    final file = File(path);
    if (file.existsSync()) {
      setState(() {
        image = file;
      });
    }
  }

  void setImage(File newImage) {
    setState(() {
      image = newImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200.0,
      width: 200.0,
      child: IconButton(
        icon: CircleAvatar(
          radius: 110,
          backgroundColor: Colors.white,
          backgroundImage: image?.existsSync() == true ?
            Image.memory(
              image.readAsBytesSync(),
              fit: BoxFit.fill,
            ).image
            :
            null,
          child: image?.existsSync() != true ?    // mivel Icon nem lehet bg image, gyerekként kell megadni
            Icon(
              Icons.account_circle_outlined,
              color: Theme.of(context).accentColor,
              size: 170,
            )
            :
            null
        ),
        tooltip: CustomLocalizations.of(context).takePicture,
        onPressed: () async {
          var newImage = await Navigator.of(context).pushNamed("/takepicture");
          if (newImage != null)
            setImage(newImage as File);
        },
      ),
    );
  }
}