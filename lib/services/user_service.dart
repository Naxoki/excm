class UserService {
  // Simulación de base de datos en memoria
  final List<Map<String, String>> _users = [];

  // Registrar un nuevo usuario
  String? register(String email, String password) {
    final exists = _users.any((user) => user['email'] == email);
    if (exists) return "El usuario ya existe.";

    _users.add({'email': email, 'password': password});
    return null; // éxito
  }

  // Validar login
  String? login(String email, String password) {
    final user = _users.firstWhere(
      (u) => u['email'] == email && u['password'] == password,
      orElse: () => {},
    );
    return user.isNotEmpty ? null : "Credenciales inválidas.";
  }
}
