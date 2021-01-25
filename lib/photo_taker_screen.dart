import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:kotprog/languages/localizations.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import 'camera_manager.dart';

class PhotoTakerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var camera = context.watch<CameraDescription>();
    return PhotoTaker(camera: camera);
  }
}

class PhotoTaker extends StatefulWidget {
  final CameraDescription camera;

  PhotoTaker({Key key, this.camera,}) : super(key: key);

  @override
  _PhotoTakerState createState() => _PhotoTakerState();
}

class _PhotoTakerState extends State<PhotoTaker> {
  Future<void> _initializeControllerFuture;
  CameraManager cameraManager;

  void initState() {
    super.initState();
    cameraManager = CameraManager(camera: widget.camera);
    _initializeControllerFuture = cameraManager.initialize();
  }

  @override
  void dispose() {
    cameraManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(CustomLocalizations.of(context).takePicture),
      ),
      body: FutureBuilder(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(cameraManager.cameraController);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: Builder(  // Builderbe wrappelve, hogy más legyen a context, így lehessen snackbart megjeleníteni
        builder: (context) =>
          FloatingActionButton(
            backgroundColor: Theme.of(context).accentColor,
            tooltip: CustomLocalizations.of(context).takePicture,
            child: Icon(Icons.camera_alt_outlined),
            onPressed: () async {
              try {
                // Inicializáljuk a kamerát
                await _initializeControllerFuture;
                // A kép mentésének a helye.
                final path = join(
                  (await getApplicationDocumentsDirectory()).path, 'dp.png');
                final file = File(path);
                if (file.existsSync()) {
                  file.deleteSync();
                }
                // Készítunk egy képet
                XFile photo = await cameraManager.cameraController.takePicture();
                photo.saveTo(path);
                // Visszaadjuk a mentett fájlt az előző képernyőnek.
                Navigator.pop(context, file);
              } catch (e) {
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content:
                    Text("${CustomLocalizations.of(context).takePictureUnsuccessful}: $e"),
                  ),
                );
              }
            },
          ),
      ),
    );
  }}