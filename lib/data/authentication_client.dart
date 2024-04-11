import 'dart:async'; // Importación de la biblioteca async para trabajar con objetos asíncronos.
import 'dart:convert'; // Importación de la biblioteca convert para convertir entre objetos Dart y JSON.

import 'package:flutter_api_rest/api/authentication_api.dart'; // Importación de la API de autenticación.
import 'package:flutter_api_rest/models/authentication_response.dart'; // Importación del modelo de respuesta de autenticación.
import 'package:flutter_api_rest/models/session.dart'; // Importación del modelo de sesión.
import 'package:flutter_api_rest/utils/logs.dart'; // Importación de los registros.
import 'package:flutter_secure_storage/flutter_secure_storage.dart'; // Importación de la biblioteca flutter_secure_storage para el almacenamiento seguro.

// Clase para el cliente de autenticación.
class AuthenticationClient {
  final FlutterSecureStorage _secureStorage; // Almacenamiento seguro para guardar la sesión.
  final AuthenticationApi _authenticationApi; // API de autenticación para realizar solicitudes de autenticación.

  Completer? _completer; // Completer para esperar la finalización de una tarea asincrónica.

  // Constructor que recibe el almacenamiento seguro y la API de autenticación.
  AuthenticationClient(this._secureStorage, this._authenticationApi);

  // Método para marcar la tarea como completa si el completer no es nulo y no está completo.
  void complete() {
    if (_completer != null && !_completer!.isCompleted) {
      _completer!.complete();
    }
  }

  // Método para obtener el token de acceso.
  Future<String?> get accessToken async {
    // Esperar la finalización de la tarea anterior si hay una.
    if (_completer != null) {
      await _completer!.future;
    }

    // Crear un completer para controlar la tarea actual.
    _completer = Completer();

    // Leer la sesión del almacenamiento seguro.
    final data = await _secureStorage.read(key: 'SESSION');
    if (data != null) {
      // Decodificar los datos de sesión.
      final session = Session.fromJson(jsonDecode(data));
      final DateTime currentDate = DateTime.now();
      final DateTime createdAt = session.createAt;
      final int expiresIn = session.expiresIn;
      final int diff = currentDate.difference(createdAt).inSeconds;
      // Registrar el tiempo de vida de la sesión.
      Logs.p.i('session life time ${expiresIn - diff}');
      // Verificar si el token aún es válido.
      if ((expiresIn - diff) >= 60) {
        complete();
        return session.token;
      }
      // Si el token ha expirado, intentar renovarlo.
      final response = await _authenticationApi.refreshToken(session.token);
      if (response.data != null) {
        // Guardar la nueva sesión y completar la tarea.
        await saveSession(response.data!);
        complete();
        return response.data!.token;
      }
      complete();
      return null;
    }
    complete();
    return null;
  }

  // Método para guardar la sesión en el almacenamiento seguro.
  Future<void> saveSession(AuthenticationResponse authenticationResponse) async {
    final Session session = Session(
      token: authenticationResponse.token,
      expiresIn: authenticationResponse.expiresIn,
      createAt: DateTime.now(),
    );
    final data = jsonEncode(session.toJson());
    await _secureStorage.write(
      key: 'SESSION',
      value: data,
    );
  }

  // Método para cerrar la sesión, eliminando todos los datos del almacenamiento seguro.
  Future<void> signOut() async {
    await _secureStorage.deleteAll();
  }
}
