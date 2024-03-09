import 'dart:async';

import 'package:flt_task/Common/Urls.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../Model/ForeCastTileProvider.dart';

class MapScreen extends StatefulWidget {
  final Position latLng;

  const MapScreen({super.key, required this.latLng});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  late LatLng currentPosition;
  bool _isTempMap = false;

  @override
  void initState() {
    super.initState();
    currentPosition = LatLng(widget.latLng.latitude, widget.latLng.longitude);
  }

  void _onMapCreated(GoogleMapController controller) {
    controller.animateCamera(CameraUpdate.newLatLng(
        LatLng(widget.latLng.latitude, widget.latLng.longitude)));
    _controller.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isTempMap?'Precipitation Layer':'Temperature Layer'),
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: currentPosition, // Set initial map center
          zoom: 10, // Set initial zoom level
        ),
        tileOverlays: {
          _isTempMap
              ? TileOverlay(
                  tileOverlayId:
                      const TileOverlayId("precipitation_tile_overlay"),
                  tileProvider: UrlTileProvider(
                    precipitationUrl,
                  ),
                  zIndex: 1,
                  fadeIn: true,
                )
              : TileOverlay(
                  tileOverlayId:
                      const TileOverlayId("temperature_tile_overlay"),
                  tileProvider: UrlTileProvider(
                    tempUrl,
                  ),
                  zIndex: 1,
                  fadeIn: true,
                )
        },
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: _isTempMap ? Colors.yellow : Colors.blue[60],
          child: _isTempMap
              ? Icon(Icons.local_fire_department_rounded)
              : Icon(Icons.cloud),
          onPressed: () {
            setState(() {
              _isTempMap = !_isTempMap;
            });
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartFloat,
    );
  }
}
