import 'package:firebase_flutter_dam/services/auth_service.dart';
import 'package:flutter/material.dart';

class TareasScreen extends StatelessWidget {
  const TareasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = AuthService();
    final user = authService.currenUser;

    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de tareas'),
        actions: [
          IconButton(
            onPressed: () async {
              // Mostrar un diálogo de confirmación
              final shouldLogout = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog.adaptive(
                  title: Text('Cerrar Sesión'),
                  content: Text('¿Estás seguro que quieres cerrar la sesión?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: Text('Cancelar'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: Text('Aceptar'),
                    ),
                  ],
                ),
              );

              if (shouldLogout == true) {
                await authService.cerrarSesion();
              }
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(child: Text('Pagina de tareas')),
      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.pushNamed(context, '/add_tarea');
      },
      child: Icon(Icons.add),),
    );
  }
}
