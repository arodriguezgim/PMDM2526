import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  // Instancia de Firebase Auth
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Me creo un Stream para que emita cambios en el estado de autenticacion.
  Stream<User?> get authStateChanges => _auth.authStateChanges();
  // Para obtener el usuario actual
  User? get currenUser => _auth.currentUser;

  /////////////////////////////////////////////////
  ///Registro Usuario con Email y Contraseña //////
  /////////////////////////////////////////////////
  Future<UserCredential?> registroConEmailYContrasena({
   //required String nombre,
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch(e) {
      // Manejo de errores específicos de Firebase
      if ( e.code == 'email-already-in-use') {
        throw Exception('Este email ya está registrado');
      } else if ( e.code == 'invalid-email') {
        throw Exception('El Email no es válido');
      } 
      throw Exception('Error al registrar Usuario: ${e.message}');
    } catch (e) {
      throw Exception('Error inesperado: $e');
    }
  }

  /////////////////////////////////////////////////
  ///  Iniciar Sesion con Email y Contraseña //////
  /////////////////////////////////////////////////
  Future<UserCredential?> iniciarSesion({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch(e) {
      // Manejo de errores específicos de Firebase
      if ( e.code == 'user-not-found') {
        throw Exception('Usuario no encontrado');
      } else if ( e.code == 'wrong-password') {
        throw Exception('Contraseña Incorrecta');
      } 
      throw Exception('Error al loguear Usuario: ${e.message}');
    } catch (e) {
      throw Exception('Error inesperado: $e');
    }
  }
  /////////////////////////
  ///  Serrar Sesion //////
  /////////////////////////
  Future<void> cerrarSesion() async {
    try {
      await _auth.signOut();
    } catch (e) {
      throw Exception('Error al cerrar la sesion: $e');
    }
  } 

}