class AuthenticationResponse {
  final String token; // Token de autenticación devuelto por la respuesta.
  final int expiresIn; // Duración de validez del token de autenticación en segundos.

  // Constructor de la clase AuthenticationResponse.
  AuthenticationResponse({
    required this.token, // Token requerido al crear una instancia de AuthenticationResponse.
    required this.expiresIn, // Duración de validez del token requerida al crear una instancia de AuthenticationResponse.
  });

  // Método estático para crear una instancia de AuthenticationResponse a partir de un mapa JSON.
  static AuthenticationResponse fromJson(Map<String, dynamic> json) {
    return AuthenticationResponse(
      token: json['token'], // Obtener el token de autenticación del mapa JSON.
      expiresIn: json['expiresIn'], // Obtener la duración de validez del token de autenticación del mapa JSON.
    );
  }
}
