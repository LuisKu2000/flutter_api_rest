import 'package:dio/dio.dart'; // Importación de la biblioteca dio para realizar solicitudes HTTP.
import 'package:flutter_api_rest/api/account_api.dart'; // Importación de la API de cuenta.
import 'package:flutter_api_rest/api/authentication_api.dart'; // Importación de la API de autenticación.
import 'package:flutter_api_rest/data/authentication_client.dart'; // Importación del cliente de autenticación.
import 'package:flutter_api_rest/helpers/http.dart'; // Importación de la clase Http.
import 'package:flutter_secure_storage/flutter_secure_storage.dart'; // Importación de la biblioteca flutter_secure_storage para almacenamiento seguro.
import 'package:get_it/get_it.dart'; // Importación de la biblioteca get_it para la inyección de dependencias.

// Clase para la inyección de dependencias.
abstract class DependencyInjection {
  // Método para inicializar las dependencias.
  static void initialize() {
    // Creación de una instancia de Dio para realizar solicitudes HTTP con la base de URL especificada.
    final Dio dio = Dio(
      BaseOptions(
        baseUrl: 'http://192.168.137.1:9000/api/v1',
      ),
    );

    // Creación de una instancia de Http para manejar las solicitudes HTTP con el cliente de Dio y habilitar los registros.
    final Http http = Http(
      dio: dio,
      logsEnable: true,
    );

    // Creación de una instancia de FlutterSecureStorage para el almacenamiento seguro.
    final _secureStorage = FlutterSecureStorage();

    // Creación de instancias de las API de autenticación y cuenta, pasando la instancia de Http y el cliente de autenticación.
    final authenticationApi = AuthenticationApi(http);
    final authenticationClient = AuthenticationClient(_secureStorage, authenticationApi);
    final accountApi = AccountApi(http, authenticationClient);

    // Registro de las instancias en GetIt para la inyección de dependencias.
    GetIt getIt = GetIt.instance;
    getIt.registerSingleton<AuthenticationApi>(authenticationApi);
    getIt.registerSingleton<AuthenticationClient>(authenticationClient);
    getIt.registerSingleton<AccountApi>(accountApi);
  }
}
