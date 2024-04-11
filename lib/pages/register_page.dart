import 'package:flutter/cupertino.dart'; // Importa el paquete 'flutter/cupertino.dart', que proporciona widgets específicos para la plataforma iOS de Flutter.
import 'package:flutter/material.dart'; // Importa el paquete 'flutter/material.dart', que proporciona widgets y herramientas para construir aplicaciones Flutter con diseño visual coherente.
import 'package:flutter_api_rest/utils/responsive.dart'; // Importa el archivo 'responsive.dart' del paquete 'flutter_api_rest/utils', que contiene una clase para manejar la responsividad de la aplicación.
import 'package:flutter_api_rest/widgets/avatar_button.dart'; // Importa el widget 'AvatarButton' del paquete 'flutter_api_rest/widgets', que muestra un botón con una imagen de avatar.
import 'package:flutter_api_rest/widgets/circle.dart'; // Importa el widget 'Circle' del paquete 'flutter_api_rest/widgets', que muestra un círculo con un gradiente de colores.
import 'package:flutter_api_rest/widgets/register_form.dart'; // Importa el widget 'RegisterForm' del paquete 'flutter_api_rest/widgets', que muestra un formulario de registro.

class RegisterPage extends StatefulWidget {
  static const String routeName = 'register'; // Nombre de la ruta de la página de registro.

  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context); // Obtiene una instancia de la clase Responsive para manejar la responsividad de la aplicación.
    final double pinkSize = responsive.wp(88); // Calcula el tamaño del círculo rosa en base al ancho de la pantalla.
    final double orangeSize = responsive.wp(60); // Calcula el tamaño del círculo naranja en base al ancho de la pantalla.

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus(); // Quita el foco de cualquier campo de texto al tocar fuera del mismo.
        },
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            height: responsive.height,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  right: -pinkSize * 0.20,
                  top: -pinkSize * 0.32,
                  child: Circle(
                    size: pinkSize,
                    colors: const [Colors.pink, Colors.pinkAccent],
                  ),
                ),
                Positioned(
                  left: -orangeSize * 0.20,
                  top: -orangeSize * 0.40,
                  child: Circle(
                    size: orangeSize,
                    colors: const [Colors.orange, Colors.deepOrangeAccent],
                  ),
                ),
                Positioned(
                  top: pinkSize * 0.20,
                  child: Column(
                    children: [
                      Text(
                        "Hello\nSign up to get started",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: responsive.dp(1.7), color: Colors.white),
                      ),
                      SizedBox(
                        height: responsive.dp(4.5),
                      ),
                      AvatarButton(
                        imageSize: responsive.wp(25),
                      )
                    ],
                  ),
                ),
                RegisterForm(), // Muestra el formulario de registro.
                Positioned(
                  left: 15,
                  top: 15,
                  child: SafeArea(
                    child: CupertinoButton(
                      onPressed: () {
                        Navigator.pop(context); // Navega hacia atrás cuando se presiona el botón de flecha hacia atrás.
                      },
                      padding: EdgeInsets.all(10),
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.black26,
                      child: Icon(Icons.arrow_back), // Icono de flecha hacia atrás.
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
