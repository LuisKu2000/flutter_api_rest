import 'package:flutter/material.dart'; // Importa el paquete 'flutter/material.dart', que proporciona widgets y herramientas para construir aplicaciones Flutter con diseño visual coherente.
import 'package:flutter_api_rest/data/authentication_client.dart'; // Importa el archivo 'authentication_client.dart' del paquete 'flutter_api_rest/data', que contiene la lógica relacionada con la autenticación del cliente.
import 'package:flutter_api_rest/pages/home_page.dart'; // Importa el archivo 'home_page.dart' del paquete 'flutter_api_rest/pages', que contiene la definición de la página principal de la aplicación.
import 'package:flutter_api_rest/pages/login_page.dart'; // Importa el archivo 'login_page.dart' del paquete 'flutter_api_rest/pages', que contiene la definición de la página de inicio de sesión de la aplicación.
import 'package:get_it/get_it.dart'; // Importa el paquete 'get_it/get_it.dart', que proporciona un contenedor de servicios para la gestión de dependencias.

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final _authenticationClient = GetIt.instance<AuthenticationClient>(); // Instancia de AuthenticationClient obtenida desde el contenedor de servicios GetIt.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CircularProgressIndicator(), // Muestra un indicador de carga circular en el cuerpo de la página.
    );
  }

  @override
  void initState() {
    super.initState();
    // Se agrega un callback al final del frame actual para ejecutar _checkLogin después de que el widget se haya construido completamente.
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _checkLogin(); // Llama al método _checkLogin después de que el widget se haya construido completamente.
    });
  }

  // Método para verificar si el usuario ya está autenticado
  Future<void> _checkLogin() async {
    final token = await _authenticationClient.accessToken; // Obtiene el token de acceso del cliente de autenticación.
    if (token == null) {
      // Si no hay token de acceso, navega a la página de inicio de sesión y reemplaza la ruta actual.
      Navigator.pushReplacementNamed(context, LoginPage.routeName);
      return;
    }
    // Si hay un token de acceso, navega a la página principal y reemplaza la ruta actual.
    Navigator.pushReplacementNamed(context, HomePage.routeName);
  }
}
