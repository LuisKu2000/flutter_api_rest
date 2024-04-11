import 'dart:typed_data'; // Importación de typed_data para manejar datos binarios.

import 'package:dio/dio.dart'; // Importación de la biblioteca Dio para realizar solicitudes HTTP.
import 'package:flutter_api_rest/data/authentication_client.dart'; // Importación del cliente de autenticación.
import 'package:flutter_api_rest/helpers/http.dart'; // Importación de la clase de ayuda Http.
import 'package:flutter_api_rest/helpers/http_response.dart'; // Importación de la clase de respuesta HTTP.
import 'package:flutter_api_rest/models/User.dart'; // Importación del modelo de usuario.

// Clase para la API de cuenta.
class AccountApi {
  final Http _http; // Objeto Http para realizar solicitudes HTTP.
  final AuthenticationClient _authenticationClient; // Cliente de autenticación para obtener el token de acceso.

  // Constructor que recibe un objeto Http y un cliente de autenticación.
  AccountApi(this._http, this._authenticationClient);

  // Método para obtener la información del usuario.
  Future<HttpResponse<User>> getUserInfo() async {
    final token = await _authenticationClient.accessToken; // Obtener el token de acceso del cliente de autenticación.
    // Realizar una solicitud HTTP GET al endpoint '/user-info' con el token de acceso en los encabezados.
    return _http.request<User>(
      '/user-info',
      method: 'GET',
      headers: {
        'token': token,
      },
      // Función de análisis para convertir los datos de respuesta en un objeto User.
      parser: (data) {
        return User.fromJson(data);
      },
    );
  }

  // Método para actualizar el avatar del usuario.
  Future<HttpResponse<String>> updateAvatar(Uint8List bytes, String filename) async {
    final token = await _authenticationClient.accessToken; // Obtener el token de acceso del cliente de autenticación.
    // Realizar una solicitud HTTP POST al endpoint '/update-avatar' con el token de acceso en los encabezados
    // y los datos binarios del avatar en el cuerpo de la solicitud.
    return _http.request<String>(
      '/update-avatar',
      method: 'POST',
      headers: {
        'token': token,
      },
      formData: {
        'attachment': MultipartFile.fromBytes(bytes, filename: filename),
      },
    );
  }
}
