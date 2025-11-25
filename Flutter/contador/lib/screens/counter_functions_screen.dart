import 'package:flutter/material.dart';

class CounterFunctionsScreen extends StatefulWidget {
  const CounterFunctionsScreen({super.key});

  @override
  State<CounterFunctionsScreen> createState() => _CounterFunctionsScreenState();
}

class _CounterFunctionsScreenState extends State<CounterFunctionsScreen> {

  int contador = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Counter Functions Screen'),
        centerTitle: true,
      ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(' $contador ', style: TextStyle( fontSize: 160, fontWeight:FontWeight.w100 ),),
              Text('Clicks', style: TextStyle(fontSize: 25),),
            ],
          ),
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            BotonPersonalizado(),
            SizedBox( height: 10,),
            BotonPersonalizado(),
            SizedBox( height: 10,),
            BotonPersonalizado(),
          ],
        ),
      );
  }
}

class BotonPersonalizado extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon( Icons.add),
        onPressed: (){
          
        }
      );
  }
}