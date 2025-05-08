import '../models/user.dart';

class UserService {
  // Singleton
  static final UserService _instance = UserService._internal();
  factory UserService() => _instance;
  UserService._internal();

  final List<User> _registeredUsers = [];
  User? _currentUser;

  // Registrar usuario
  String? register(String email, String password) {
    final userExists = _registeredUsers.any((user) => user.email == email);
    if (userExists) {
      return 'El email ya está registrado';
    }
    _registeredUsers.add(User(email: email, password: password));
    return null;
  }

  // Login
  String? login(String email, String password) {
    final user = _registeredUsers.firstWhere(
      (user) => user.email == email && user.password == password,
      orElse: () => User(email: '', password: ''),
    );
    if (user.email.isEmpty) {
      return 'Usuario o contraseña incorrectos';
    }
    _currentUser = user;
    return null;
  }

  // Obtener usuario actual
  Future<User?> getCurrentUser() async => _currentUser;

  // Logout
  Future<void> logout() async {
    _currentUser = null;
  }

  // Agregar un producto al usuario actual
  void addProductToCurrentUser(String product) {
    if (_currentUser != null) {
      _currentUser = User(
        email: _currentUser!.email,
        password: _currentUser!.password,
        products: [..._currentUser!.products, product],
      );
    }
  }
}
