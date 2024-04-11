class UserRegisterModel {
  final String _username; // Nombre de usuario.
  final String _email; // Correo electrónico.
  final String _password; // Contraseña.

  // Constructor de la clase UserRegisterModel.
  UserRegisterModel({
    required String username, // Nombre de usuario requerido al crear una instancia.
    required String email, // Correo electrónico requerido al crear una instancia.
    required String password, // Contraseña requerida al crear una instancia.
  })   : _password = password, // Asignación del valor de la contraseña.
        _email = email, // Asignación del valor del correo electrónico.
        _username = username; // Asignación del valor del nombre de usuario.

  // Getter para obtener el nombre de usuario.
  String get username => _username;

  // Getter para obtener el correo electrónico.
  String get email => _email;

  // Getter para obtener la contraseña.
  String get password => _password;
}
