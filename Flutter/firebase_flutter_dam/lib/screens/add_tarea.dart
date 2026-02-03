import 'package:flutter/material.dart';

class AddTareaScreen extends StatelessWidget {
   
  const AddTareaScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('AddTarea'),), 
      body: Center(
         child: Text('AddTareaScreen'),
      ),
    );
  }
}