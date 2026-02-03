import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  // Instancia de Firebase Auth
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Instancia de GoogleSignIn
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
  static bool isInitialize = false;

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
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      // Manejo de errores específicos de Firebase
      if (e.code == 'email-already-in-use') {
        throw Exception('Este email ya está registrado');
      } else if (e.code == 'invalid-email') {
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
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      // Manejo de errores específicos de Firebase
      if (e.code == 'user-not-found') {
        throw Exception('Usuario no encontrado');
      } else if (e.code == 'wrong-password') {
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

  /////////////////////////////////////////////////
  ///  Iniciar Sesion con Google             //////
  /////////////////////////////////////////////////
  Future<void> initSignIn() async {
    if (!isInitialize) {
      await _googleSignIn.initialize(
        serverClientId:
            '19546367798-kafs4teis7hmssad2rfrrdkjcmm1r0ej.apps.googleusercontent.com',
      );
      isInitialize = true;
    }
  }

  // Iniciar sesion con Google 7.2.0
  Future<UserCredential?> loginConGoogle() async {
    try {
      // 1 - Iniciamos el servicio de Google Sign In
      // Esto configiura el client ID del servidor necesario para autenticarnos
      initSignIn();
      // 2 - Auntenticar el usuario con Google: Abre la ventanita para seleccionar la cuenta.
      final GoogleSignInAccount googleUser = await _googleSignIn.authenticate();

      // Si el usuario cancela esa ventana, se podria retornar nulo.
      if (googleUser == null) return null;

      // 3 - Obtener el idToken: es un token JWT que contiene la informacion del usuario
      final idToken = googleUser.authentication.idToken;
      // 4 - Obtenemos el cliente de autorizacion: Este cliente nos permite solicitar los permisos específicos
      final authorizationClient = googleUser.authorizationClient;

      // 5 -  Solicitamos autorizacion para los scopes email y profile
      GoogleSignInClientAuthorization? authorization = await authorizationClient
          .authorizationForScopes(['email', 'profile']);

      // 6 - Obtenemos el accessToken
      final accesToken = authorization?.accessToken;
      // 7 - Validamos el token
      if (accesToken == null) {
        final authorization2 = await authorizationClient.authorizationForScopes(
          ['email', 'profile'],
        );
        // Si tampoco funciona lanzamos un error
        if (authorization2?.accessToken != null) {
          throw FirebaseAuthException(code: 'ERROR CODIGO');
        }
        authorization = authorization2;
      }

      // 8 - Creamos las credenciales para Firebase
      final credential = GoogleAuthProvider.credential(
        idToken: idToken,
        accessToken: accesToken,
      );
      // 9 - Nos logueamos con Firebase
      final UserCredential userCredential = await _auth.signInWithCredential(
        credential,
      );
      // 10 - Obtenemos el objeto User de Firebase
      final User? user = userCredential.user;
      // 11 - Procesamos la informacion adicional del usuario
      if (user != null) {
        // Aqui podemosmeter informacion en una base de datos de Firebase
      }
      // 12 - Devolvemos las credenciales del usuario identificado
      return userCredential;

    } catch (e) {
      print('Error en Login con Google: $e');
    }

    // Si hubo algun error
    return null;
  }
}
