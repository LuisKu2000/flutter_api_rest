import 'package:flutter/material.dart'; // Importa el paquete 'flutter/material.dart', que proporciona widgets y herramientas para construir aplicaciones Flutter con diseño visual coherente.
import 'package:flutter_api_rest/utils/responsive.dart'; // Importa el archivo 'responsive.dart' del paquete 'flutter_api_rest/utils', que contiene una clase para manejar la responsividad de la aplicación.
import 'package:flutter_api_rest/widgets/circle.dart'; // Importa el widget 'Circle' del paquete 'flutter_api_rest/widgets', que muestra un círculo con un gradiente de colores.
import 'package:flutter_api_rest/widgets/icon_container.dart'; // Importa el widget 'IconContainer' del paquete 'flutter_api_rest/widgets', que muestra un contenedor con un icono SVG.
import 'package:flutter_api_rest/widgets/login_form.dart'; // Importa el widget 'LoginForm' del paquete 'flutter_api_rest/widgets', que muestra un formulario de inicio de sesión.

class LoginPage extends StatefulWidget {
  static const String routeName = 'login'; // Nombre de la ruta de la página de inicio de sesión.

  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context); // Obtiene una instancia de la clase Responsive para manejar la responsividad de la aplicación.
    final double pinkSize = responsive.wp(80); // Calcula el tamaño del círculo rosa en base al ancho de la pantalla.
    final double orangeSize = responsive.wp(57); // Calcula el tamaño del círculo naranja en base al ancho de la pantalla.

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus(); // Quita el foco de cualquier campo de texto al tocar fuera del mismo.
        },
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            height: responsive.height, // Establece la altura del contenedor según la altura de la pantalla.
            child: Stack(
              alignment: Alignment.center, // Establece la alineación de los elementos apilados en el centro.
              children: [
                Positioned(
                  right: -pinkSize * 0.2, // Posiciona el círculo rosa hacia la derecha y ligeramente hacia arriba.
                  top: -pinkSize * 0.4,
                  child: Circle(
                    size: pinkSize,
                    colors: const [
                      Colors.pink,
                      Colors.pinkAccent
                    ],
                  ),
                ),
                Positioned(
                  left: -orangeSize * 0.15, // Posiciona el círculo naranja hacia la izquierda y ligeramente hacia arriba.
                  top: -orangeSize * 0.55,
                  child: Circle(
                    size: orangeSize,
                    colors: const [
                      Colors.orange,
                      Colors.deepOrangeAccent
                    ],
                  ),
                ),
                Positioned(
                  top: pinkSize * 0.4, // Posiciona el contenido principal hacia abajo desde la parte superior del círculo rosa.
                  child: Column(
                    children: [
                      IconContainer( // Muestra un contenedor con un icono SVG.
                        size: responsive.wp(17),
                      ),
                      SizedBox(
                        height: responsive.dp(3), // Espacio vertical entre el contenedor de icono y el texto.
                      ),
                      Text(
                        "Hello Again\nWelcome Back", // Texto de bienvenida.
                        textAlign: TextAlign.center, // Alinea el texto al centro.
                        style: TextStyle(
                          fontSize: responsive.dp(1.7) // Tamaño del texto.
                        ),
                      ),
                    ],
                  ),
                ),
                const LoginForm(), // Muestra el formulario de inicio de sesión.
              ],
            ),
          ),
        ),
      ),
    );
  }
}
