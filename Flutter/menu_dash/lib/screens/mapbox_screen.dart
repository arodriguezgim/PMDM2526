import 'package:flutter/material.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

class MapBoxScreen extends StatelessWidget {
   
  const MapBoxScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    MapboxMap? _mapboxMap;

    Position plazaTorico = Position(-1.1071004291260438, 40.342789790692194);

    CameraOptions camara = CameraOptions( 
      center: Point(coordinates: plazaTorico),
      zoom: 14.0,
      bearing: -161.81,
      pitch: 70.0
    );

    _onMapCreated(MapboxMap mapboxMap){
      _mapboxMap = mapboxMap;

      // Animacion
      mapboxMap.flyTo(camara, MapAnimationOptions(
        duration: 10000,
        startDelay: 2000,
      ));
    }




    return Scaffold(
      appBar: AppBar(title: Text('MapBox'),), 
      body: MapWidget(
        styleUri: MapboxStyles.STANDARD,
        cameraOptions: CameraOptions(
          center: Point(coordinates: Position(-73.96995024184675, 40.63834047429947)),
          zoom: 14,
        ),
        onMapCreated: _onMapCreated,
      )
    );
  }
}