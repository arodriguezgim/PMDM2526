import 'package:componentes/presentation/widgets/tarjeta_personalizada_1.dart';
import 'package:componentes/presentation/widgets/tarjeta_personalizada_2.dart';
import 'package:flutter/material.dart';

class TarjetasScreen extends StatelessWidget {
  const TarjetasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(title: Text('Tarjetas'),),
      body: ListView(
        children: [
          TarjetaPersonalizada1(),
          TarjetaPersonalizada2(),

        ],
      ),
    );
  }
}

