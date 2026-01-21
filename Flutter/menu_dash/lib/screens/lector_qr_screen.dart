import 'package:flutter/material.dart';

class LectorQRScreen extends StatefulWidget {
   
  const LectorQRScreen({Key? key}) : super(key: key);

  @override
  State<LectorQRScreen> createState() => _LectorQRScreenState();
}

class _LectorQRScreenState extends State<LectorQRScreen> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('LectorQR'),), 
      body: Center(
         child: Text('LectorQRScreen'),
      ),
    );
  }
}