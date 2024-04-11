class User {
  final String id; // Identificador único del usuario.
  final String username; // Nombre de usuario del usuario.
  final String email; // Correo electrónico del usuario.
  final DateTime createdAt; // Fecha de creación del usuario.
  final DateTime updatedAt; // Fecha de actualización del usuario.
  final String avatar; // URL del avatar del usuario.

  // Constructor de la clase User.
  User({
    required this.id,
    required this.username,
    required this.email,
    required this.createdAt,
    required this.updatedAt,
    required this.avatar,
  });

  // Factory method para convertir un objeto JSON en una instancia de User.
  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"], // ID del usuario obtenido del JSON.
        username: json["username"], // Nombre de usuario obtenido del JSON.
        email: json["email"], // Correo electrónico obtenido del JSON.
        createdAt: DateTime.parse(json["createdAt"]), // Fecha de creación convertida de String a DateTime.
        updatedAt: DateTime.parse(json["updatedAt"]), // Fecha de actualización convertida de String a DateTime.
        avatar: json['avatar'], // URL del avatar obtenida del JSON.
      );

  // Método para convertir una instancia de User en un objeto JSON.
  Map<String, dynamic> toJson() => {
        "_id": id,
        "username": username,
        "email": email,
        "createdAt": createdAt.toIso8601String(), // Fecha de creación convertida a String.
        "updatedAt": updatedAt.toIso8601String(), // Fecha de actualización convertida a String.
        'avatar': avatar,
      };

  // Método para crear una copia de la instancia de User con algunas propiedades actualizadas.
  User copyWith({
    String? id,
    String? username,
    String? email,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? avatar,
  }) =>
      User(
        id: id ?? this.id, // Si id no es nulo, usa el nuevo valor, de lo contrario, mantiene el valor existente.
        username: username ?? this.username, // Si username no es nulo, usa el nuevo valor, de lo contrario, mantiene el valor existente.
        email: email ?? this.email, // Si email no es nulo, usa el nuevo valor, de lo contrario, mantiene el valor existente.
        createdAt: createdAt ?? this.createdAt, // Si createdAt no es nulo, usa el nuevo valor, de lo contrario, mantiene el valor existente.
        updatedAt: updatedAt ?? this.updatedAt, // Si updatedAt no es nulo, usa el nuevo valor, de lo contrario, mantiene el valor existente.
        avatar: avatar ?? this.avatar, // Si avatar no es nulo, usa el nuevo valor, de lo contrario, mantiene el valor existente.
      );
}
