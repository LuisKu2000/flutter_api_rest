import 'dart:convert'; // Importa la biblioteca 'dart:convert', que proporciona funciones para codificar y decodificar datos en formatos como JSON.

import 'package:flutter/material.dart'; // Importa el paquete 'flutter/material.dart', que proporciona widgets y herramientas para construir aplicaciones Flutter con diseño visual coherente.
import 'package:flutter_api_rest/api/authentication_api.dart'; // Importa la API de autenticación del proyecto.
import 'package:flutter_api_rest/models/user_register_model.dart'; // Importa el modelo de usuario para el registro.
import 'package:flutter_api_rest/data/authentication_client.dart'; // Importa el cliente de autenticación del proyecto.
import 'package:flutter_api_rest/pages/home_page.dart'; // Importa la página de inicio del proyecto.
import 'package:flutter_api_rest/utils/dialogs.dart'; // Importa utilidades para mostrar diálogos.
import 'package:flutter_api_rest/utils/responsive.dart'; // Importa utilidades para manejar el diseño responsivo.
import 'package:flutter_api_rest/widgets/input_text.dart'; // Importa un widget personalizado de campo de texto de entrada.
import 'package:get_it/get_it.dart'; // Importa el paquete GetIt, que proporciona un contenedor de servicio para la inyección de dependencias.

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final GlobalKey<FormState> _formKey = GlobalKey(); // Clave global para identificar el formulario.
  String _email = '', _password = '', _username = ''; // Variables para almacenar datos de entrada.
  final _authenticationApi = GetIt.instance<AuthenticationApi>(); // Instancia de la API de autenticación.
  final _authenticationClient = GetIt.instance<AuthenticationClient>(); // Instancia del cliente de autenticación.

  Future<void>_submit() async {
    final bool isOk = _formKey.currentState!.validate(); // Valida el formulario.
    if (isOk) {
      ProgressDialog.show(context); // Muestra un diálogo de progreso.
      final response = await _authenticationApi.register( // Envía una solicitud de registro a la API.
          userRegister: UserRegisterModel(
              username: _username,
              email: _email,
              password: _password
          ),
      );
      ProgressDialog.dismiss(context); // Cierra el diálogo de progreso.
      if (response.data != null) {
        await _authenticationClient.saveSession(response.data!); // Guarda la sesión del usuario.
        Navigator.pushNamedAndRemoveUntil(context, HomePage.routeName, (_) => false); // Navega a la página de inicio y elimina las rutas anteriores.
      }
      else {
        String message = response.error!.message; // Mensaje de error predeterminado.

        if (response.error!.statusCode == -1) {
          message = 'Bad Network'; // Mensaje de error para problemas de red.
        }
        else if (response.error!.statusCode == 409) {
          message = 'Duplicate user ${jsonEncode(response.error!.data['duplicatedFields'])}'; // Mensaje de error para usuario duplicado.
        }

        Dialogs.alert(
            context,
            title: 'Error',
            description: message // Muestra un diálogo de error con el mensaje correspondiente.
        );
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
              label: "USERNAME",
              fontSize: responsive.dp(responsive.isTablet ? 1.2 :1.4),
              onChanged: (text){
                _username = text; // Captura el texto ingresado para el nombre de usuario.
              },
              validator: (text){
                if(text!.trim().length < 5){
                  return "Invalid username"; // Valida la entrada del nombre de usuario.
                }
                return null;
              },
            ),
            SizedBox(height: responsive.dp(2)), // Espacio vertical entre los campos de entrada.
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
            InputText(
              obscureText: true, // Hace que la contraseña sea oculta.
              label: "PASSWORD",
              fontSize: responsive.dp(responsive.isTablet ? 1.2 :1.4),
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
            SizedBox(height: responsive.dp(8)), // Espacio vertical entre los campos de entrada.
            SizedBox(
              width: double.infinity, // El botón ocupa todo el ancho disponible.
              child: MaterialButton(
                padding: const EdgeInsets.symmetric(vertical: 15),
                color: Colors.pinkAccent,
                onPressed: (){
                  _submit(); // Maneja la acción de enviar el formulario.
                },
                child: const Text(
                  "Sign up",
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
                Text("Already have an account?", style: TextStyle(fontSize: responsive.dp(1.5)),),
                MaterialButton(
                  child: Text(
                  "Sign in",
                  style: TextStyle(
                    color: Colors.pinkAccent,
                    fontSize: responsive.dp(1.5),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context); // Navega de vuelta a la página anterior.
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
