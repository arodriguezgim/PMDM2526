import 'package:flutter/material.dart';

class BotonesScreen extends StatelessWidget {
  const BotonesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( title: Text('Botones'),),
      body: _BotonesScreenView(),
      floatingActionButton: FloatingActionButton(
        child: Icon( Icons.arrow_back_ios),
        onPressed: (){
          Navigator.pop(context);
        },
        ),
    );
  }
}


class _BotonesScreenView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsetsGeometry.symmetric(vertical: 5, horizontal: 10),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {  }, 
              child: Text('ElevatedButton'),
              ),
            ElevatedButton.icon(
              onPressed: (){},
              label: Text('ElevatedButton Icon'),
              icon: Icon( Icons.access_alarm_outlined),
              ),
          ],
        ),
      ),
    );
  }
}