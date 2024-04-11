// ignore_for_file: use_build_context_synchronously // Ignora las advertencias relacionadas con el uso síncrono del contexto de construcción.

import 'package:flutter/material.dart'; // Importa el paquete 'flutter/material.dart', que proporciona widgets y herramientas para construir aplicaciones Flutter con diseño visual coherente.
import 'package:flutter_api_rest/api/authentication_api.dart'; // Importa la API de autenticación del proyecto.
import 'package:flutter_api_rest/data/authentication_client.dart'; // Importa el cliente de autenticación del proyecto.
import 'package:flutter_api_rest/models/user_credential_model.dart'; // Importa el modelo de credencial de usuario.
import 'package:flutter_api_rest/pages/home_page.dart'; // Importa la página de inicio del proyecto.
import 'package:flutter_api_rest/utils/dialogs.dart'; // Importa utilidades para mostrar diálogos.
import 'package:flutter_api_rest/utils/responsive.dart'; // Importa utilidades para manejar el diseño responsivo.
import 'package:flutter_api_rest/widgets/input_text.dart'; // Importa un widget personalizado de campo de texto de entrada.
import 'package:get_it/get_it.dart'; // Importa el paquete GetIt, que proporciona un contenedor de servicio para la inyección de dependencias.

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey(); // Clave global para identificar el formulario.
  final _authenticationApi = GetIt.instance<AuthenticationApi>(); // Instancia de la API de autenticación.
  final _authenticationClient = GetIt.instance<AuthenticationClient>(); // Instancia del cliente de autenticación.
  String _email = '', _password = ''; // Variables para almacenar datos de entrada.

  Future<void> _submit() async {
    final bool isOk = _formKey.currentState!.validate(); // Valida el formulario.
    if (isOk) {
      ProgressDialog.show(context); // Muestra un diálogo de progreso.

      final response = await _authenticationApi.login( // Envía una solicitud de inicio de sesión a la API.
          userCredential:
              UserCredentialModel(email: _email, password: _password));
      ProgressDialog.dismiss(context); // Cierra el diálogo de progreso.

      if (response.data != null) {
        await _authenticationClient.saveSession(response.data!); // Guarda la sesión del usuario.
        Navigator.pushNamedAndRemoveUntil(
          context,
          HomePage.routeName,
          (_) => false,
        ); // Navega a la página de inicio y elimina las rutas anteriores.
      } else {
        String message = response.error!.message; // Mensaje de error predeterminado.

        if (response.error!.statusCode == -1) {
          message = 'Bad Network'; // Mensaje de error para problemas de red.
        } else if (response.error!.statusCode == 403) {
          message = 'Invalid password'; // Mensaje de error para contraseña no válida.
        } else if (response.error!.statusCode == 404) {
          message = 'User not found'; // Mensaje de error para usuario no encontrado.
        }

        Dialogs.alert(context, title: 'Error', description: message); // Muestra un diálogo de error con el mensaje correspondiente.
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context); // Obtiene el objeto Responsivo para manejar el diseño adaptativo.

    return Positioned(
      bottom: 30, // Posiciona el widget en la parte inferior de la pantalla.
      child: Container(
        constraints: BoxConstraints(
              maxWidth: responsive.isTablet ? 430 : 360, // Limita el ancho máximo del contenedor según el tamaño del dispositivo.
            ),
        child: Form(
          key: _formKey, // Asigna la clave global al formulario.
          child: Column(
          children: <Widget>[
            InputText(
              keyboardType: TextInputType.emailAddress,
              label: "EMAIL ADDRESS",
              fontSize: responsive.dp(responsive.isTablet ? 1.2 :1.4),
              onChanged: (text){
                _email = text; // Captura el texto ingresado para la dirección de correo electrónico.
              },
              validator: (text){
                if(!text!.contains('@')){
                  return "Invalid email"; // Valida la entrada del correo electrónico.
                }
                return null;
              },
            ),
            SizedBox(height: responsive.dp(2)), // Espacio vertical entre los campos de entrada.
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.black26,
                  ),
                ),
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: InputText(
                      obscureText: true,
                      label: "PASSWORD",
                      borderEnabled: false,
                      fontSize: responsive.dp(responsive.isTablet ? 1.2 : 1.4),
                      onChanged: (text){
                        _password = text; // Captura el texto ingresado para la contraseña.
                      },
                      validator: (text){
                        if(text?.trim().isEmpty == true){
                          return "Invalid password"; // Valida la entrada de la contraseña.
                        }
                        return null;
                      },
                    ),
                  ),
                  // Botón de texto para olvidar la contraseña.
                  TextButton(
                    onPressed: () {}, // Sin realizar ninguna acción
                    child: const Text(
                      "Forgot Password",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: responsive.dp(4)), // Espacio vertical entre los campos de entrada.
            SizedBox(
              width: double.infinity, // El botón ocupa todo el ancho disponible.
              child: MaterialButton(
                padding: const EdgeInsets.symmetric(vertical: 15),
                color: Colors.pinkAccent,
                onPressed: (){
                  _submit(); // Maneja la acción de enviar el formulario.
                },
                child: const Text(
                  "Sign in",
                  style: TextStyle(
                    color: Colors.white
                  ),
                ),
              ),
            ),
            SizedBox(height: responsive.dp(2)), // Espacio vertical entre los campos de entrada.
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("New to Friendly Desi?", style: TextStyle(fontSize: responsive.dp(1.5)),),
                MaterialButton(
                  child: Text(
                  "Sign up",
                  style: TextStyle(
                    color: Colors.pinkAccent,
                    fontSize: responsive.dp(1.5),
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, 'register'); // Navega a la página de registro.
                },
                ),
              ],
            ),
            SizedBox(height: responsive.dp(10)), // Espacio vertical adicional al final del formulario.
          ],
                ),
        ),
      ),
    );
  }
}
