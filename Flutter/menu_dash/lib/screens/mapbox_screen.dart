import 'package:flutter/material.dart';

class MapBoxScreen extends StatelessWidget {
   
  const MapBoxScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('MapBox'),), 
      body: Center(
         child: Text('MapBoxScreen'),
      ),
    );
  }
}