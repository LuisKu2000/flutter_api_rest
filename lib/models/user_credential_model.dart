class UserCredentialModel {
  final String _email; // Correo electrónico del usuario.
  final String _password; // Contraseña del usuario.

  // Constructor de la clase UserCredentialModel.
  UserCredentialModel({
    required String email, // Correo electrónico requerido al crear una instancia.
    required String password, // Contraseña requerida al crear una instancia.
  })   : _password = password, // Asignación del valor de la contraseña.
        _email = email; // Asignación del valor del correo electrónico.

  // Getter para obtener el correo electrónico.
  String get email => _email;

  // Getter para obtener la contraseña.
  String get password => _password;
}
