import 'package:componentes/config/routes/menu_items.dart';
import 'package:componentes/presentation/screens/botones_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
        ),
      body: ListView.builder(
        itemCount: menuItems.length,
        itemBuilder: (context, index) {
          final menuItem = menuItems[index];
          return ListTile(
            title: Text( menuItem.titulo ),
            subtitle: Text( menuItem.subtitulo ),
            leading: Icon( menuItem.icono ),
            trailing: Icon( Icons.arrow_forward_ios),
            onTap: () {
              // Navegar a otra pantalla
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => BotonesScreen(),
                  )
              );
            },
            
          );
        },
        )
    );
  }
}