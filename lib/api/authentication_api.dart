import 'package:flutter_api_rest/models/user_credential_model.dart'; // Importación del modelo de credenciales de usuario.
import 'package:flutter_api_rest/models/user_register_model.dart'; // Importación del modelo de registro de usuario.
import 'package:flutter_api_rest/helpers/http.dart'; // Importación de la clase de ayuda Http.
import 'package:flutter_api_rest/helpers/http_response.dart'; // Importación de la clase de respuesta HTTP.
import 'package:flutter_api_rest/models/authentication_response.dart'; // Importación del modelo de respuesta de autenticación.

// Clase para la API de autenticación.
class AuthenticationApi {
  final Http _http; // Objeto Http para realizar solicitudes HTTP.

  // Constructor que recibe un objeto Http.
  AuthenticationApi(this._http);

  // Método para registrar un nuevo usuario.
  Future<HttpResponse<AuthenticationResponse>> register({
    required UserRegisterModel userRegister,
  }) {
    // Realizar una solicitud HTTP POST al endpoint '/register' con los datos del usuario.
    return _http.request<AuthenticationResponse>(
      '/register',
      method: 'POST',
      data: {
        "username": userRegister.username,
        "email": userRegister.email,
        "password": userRegister.password,
      },
      // Función de análisis para convertir los datos de respuesta en un objeto AuthenticationResponse.
      parser: (data) {
        return AuthenticationResponse.fromJson(data);
      },
    );
  }

  // Método para iniciar sesión con las credenciales de usuario.
  Future<HttpResponse<AuthenticationResponse>> login({
    required UserCredentialModel userCredential,
  }) async {
    // Realizar una solicitud HTTP POST al endpoint '/login' con las credenciales de usuario.
    return _http.request<AuthenticationResponse>(
      '/login',
      method: 'POST',
      data: {
        "email": userCredential.email,
        "password": userCredential.password,
      },
      // Función de análisis para convertir los datos de respuesta en un objeto AuthenticationResponse.
      parser: (data) {
        return AuthenticationResponse.fromJson(data);
      },
    );
  }

  // Método para renovar el token de acceso.
  Future<HttpResponse<AuthenticationResponse>> refreshToken(String expiredToken) {
    // Realizar una solicitud HTTP POST al endpoint '/refresh-token' con el token de acceso expirado.
    return _http.request<AuthenticationResponse>(
      '/refresh-token',
      method: 'POST',
      headers: {
        'token': expiredToken,
      },
      // Función de análisis para convertir los datos de respuesta en un objeto AuthenticationResponse.
      parser: (data) {
        return AuthenticationResponse.fromJson(data);
      },
    );
  }
}
