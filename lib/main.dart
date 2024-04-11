// Importaciones necesarias para el proyecto Flutter
import 'package:flutter/material.dart'; // Importa el paquete Flutter Material, que proporciona widgets y herramientas para la construcción de aplicaciones Flutter con diseño visual coherente.
import 'package:flutter/services.dart'; // Importa el paquete Flutter Services, que proporciona acceso a las funcionalidades del sistema subyacente.
import 'package:flutter_api_rest/helpers/dependency_injection.dart'; // Importa una clase o archivo relacionado con la inyección de dependencias en el proyecto.
import 'package:flutter_api_rest/pages/home_page.dart'; // Importa la página de inicio de la aplicación.
import 'package:flutter_api_rest/pages/login_page.dart'; // Importa la página de inicio de sesión de la aplicación.
import 'package:flutter_api_rest/pages/register_page.dart'; // Importa la página de registro de la aplicación.
import 'package:flutter_api_rest/pages/splash_page.dart'; // Importa la página de bienvenida de la aplicación.

// Función principal de inicio del programa Flutter
void main() { 
  // Inicialización de la inyección de dependencias
  DependencyInjection.initialize(); // Inicializa la inyección de dependencias en el proyecto.
  // Ejecución de la aplicación Flutter
  runApp(const MyApp()); // Ejecuta la aplicación Flutter creando una instancia de la clase MyApp y la pasa a la función runApp().
}

// Clase principal de la aplicación Flutter
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Configuración de las orientaciones preferidas de la pantalla
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]); // Configura las orientaciones preferidas de la pantalla a retrato hacia arriba y retrato hacia abajo.
    // Devuelve un MaterialApp que contiene la estructura de la aplicación
    return MaterialApp(
      // Desactiva el banner de depuración
      debugShowCheckedModeBanner: false, // Desactiva el banner de depuración en la esquina superior derecha de la aplicación.
      // Tema de la aplicación
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple), // Define un esquema de color para la aplicación con un color base de púrpura profundo.
        useMaterial3: true, // Habilita el uso de Material3, la próxima versión de Material Design.
      ),
      // Página inicial de la aplicación
      home: const SplashPage(), // Define la página de bienvenida como la página inicial de la aplicación.
      // Rutas de la aplicación
      routes: {
        RegisterPage.routeName : (_) => const RegisterPage(), // Define la ruta y constructor para la página de registro de la aplicación.
        LoginPage.routeName : (_) => const LoginPage(), // Define la ruta y constructor para la página de inicio de sesión de la aplicación.
        HomePage.routeName : (_) => const HomePage(), // Define la ruta y constructor para la página de inicio de la aplicación.
      },
    );
  }
}