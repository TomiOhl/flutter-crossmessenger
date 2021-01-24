import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import "package:latlong/latlong.dart";

class Map extends StatelessWidget {
  final MapController mapController;

  const Map({Key key, @required this.mapController}) : super(key: key);

  void updateLocation(double latitude, double longitude) {
    mapController.move(new LatLng(latitude, longitude), 13.0);
  }

  Widget build(BuildContext context) {
    return new FlutterMap(
      options: new MapOptions(
        center: new LatLng(48.7443166, 20.5752032),
        zoom: 13.0,
      ),
      mapController: mapController,
      layers: [
        new TileLayerOptions(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c']
        ),
        new MarkerLayerOptions(
          markers: [
            new Marker(
              point: new LatLng(48.7443166, 20.5752032),
              builder: (ctx) =>
              new Container(
                child: Icon(
                  Icons.my_location,
                  color: Theme.of(context).accentColor,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

}