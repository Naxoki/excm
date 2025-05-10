import 'package:firebase_auth/firebase_auth.dart';

class UserService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // 🔹 Registrar usuario
  Future<String?> register(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return null; // éxito
    } on FirebaseAuthException catch (e) {
      return e.message; // error
    }
  }

  // 🔹 Iniciar sesión
  Future<String?> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return null; // éxito
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  // 🔹 Cerrar sesión
  Future<void> logout() async {
    await _auth.signOut();
  }

  // 🔹 Obtener usuario actual
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  // 🔹 Saber si hay sesión activa
  bool isLoggedIn() {
    return _auth.currentUser != null;
  }
}
