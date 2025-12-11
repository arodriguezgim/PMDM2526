import 'package:flutter/material.dart';

// Este provider va a manejar el contador de lapagina 1
// ChangeNotifier es una clase que proporciona notificaciones a los Widgets cuando el estado cambia
class ContadorProvider extends ChangeNotifier {

  int _contador = 0;
  // Cuando tenemos un estado con Provider hemos de poder hacer DOS cosas:
  // 1 - Poder leer el valor de ese estado
  // 2 - Poder modificar el valor de este estado
  int get contador => _contador;

  void incrementar(){
    _contador++;
    notifyListeners();
  }

  void decrementar(){
    _contador--;
    notifyListeners();
  }
  
}