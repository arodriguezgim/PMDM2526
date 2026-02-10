import 'package:shared_preferences/shared_preferences.dart';

class Preferencias {
  static late SharedPreferences _preferencias;

  // Aquí creo las propiedades globales que quiero manejar
  static String _nombre = '';
  static bool _isDarkMode = false;
  static bool _ubicacionUsuario = false;
  static bool _camaraPermiso = false;

  static Future init() async {
    _preferencias = await SharedPreferences.getInstance();
  }

  // Me creo los métodos que me devolverán los valores
  static get nombre {
    return _preferencias.getString('nombre') ?? _nombre;
  }

  static set nombre(String nombre) {
    _nombre = nombre;
    _preferencias.setString('nombre', nombre);
  }

  static get isDarkMode {
    return _preferencias.getBool('modo_oscuro') ?? _isDarkMode;
  }

  static set isDarkMode(bool darkMode) {
    _isDarkMode = darkMode;
    _preferencias.setBool('modo_oscuro', darkMode);
  }

  static get camara {
    return _preferencias.getBool('camara') ?? _camaraPermiso;
  }

  static set camara(bool camara) {
    _camaraPermiso = camara;
    _preferencias.setBool('camara', camara);
  }

  static get ubicacion {
    return _preferencias.getBool('ubicacion') ?? _ubicacionUsuario;
  }

  static set ubicacion(bool ubicacion) {
    _ubicacionUsuario = ubicacion;
    _preferencias.setBool('ubicacion', ubicacion);
  }
}
