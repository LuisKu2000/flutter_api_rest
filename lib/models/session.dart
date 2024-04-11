class Session {
  final String token; // Token de la sesión.
  final int expiresIn; // Duración de la sesión en segundos.
  final DateTime createAt; // Fecha y hora de creación de la sesión.

  // Constructor de la clase Session.
  Session({
    required this.token, // Token requerido al crear una instancia de la sesión.
    required this.expiresIn, // Duración de la sesión requerida al crear una instancia.
    required this.createAt, // Fecha y hora de creación de la sesión requerida al crear una instancia.
  });

  // Método estático para crear una instancia de Session a partir de un mapa JSON.
  static Session fromJson(Map<String, dynamic> json) {
    return Session(
      token: json['token'], // Obtener el token del mapa JSON.
      expiresIn: json['expiresIn'], // Obtener la duración de la sesión del mapa JSON.
      createAt: DateTime.parse(json['createAt']), // Obtener la fecha y hora de creación de la sesión del mapa JSON.
    );
  }

  // Método para convertir la instancia de Session a un mapa JSON.
  Map<String, dynamic> toJson() {
    return {
      'token': token, // Agregar el token al mapa JSON.
      'expiresIn': expiresIn, // Agregar la duración de la sesión al mapa JSON.
      'createAt': createAt.toIso8601String(), // Agregar la fecha y hora de creación de la sesión al mapa JSON.
    };
  }
}
