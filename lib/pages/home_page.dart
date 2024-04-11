import 'dart:typed_data'; // Importa el paquete 'dart:typed_data' para trabajar con datos binarios.

import 'package:flutter/material.dart'; // Importa el paquete 'flutter/material.dart', que proporciona widgets y herramientas para construir aplicaciones Flutter con diseño visual coherente.
import 'package:flutter_api_rest/api/account_api.dart'; // Importa el archivo 'account_api.dart' del paquete 'flutter_api_rest/api', que contiene la lógica para interactuar con la API de la cuenta.
import 'package:flutter_api_rest/data/authentication_client.dart'; // Importa el archivo 'authentication_client.dart' del paquete 'flutter_api_rest/data', que maneja la autenticación del cliente.
import 'package:flutter_api_rest/models/User.dart'; // Importa el modelo 'User' del paquete 'flutter_api_rest/models', que define la estructura de un usuario.
import 'package:flutter_api_rest/pages/login_page.dart'; // Importa el archivo 'login_page.dart' del paquete 'flutter_api_rest/pages', que contiene la página de inicio de sesión.
import 'package:flutter_api_rest/utils/logs.dart'; // Importa el archivo 'logs.dart' del paquete 'flutter_api_rest/utils', que proporciona funciones de registro.
import 'package:get_it/get_it.dart'; // Importa el paquete 'get_it/get_it.dart', que proporciona un contenedor de servicios para la inyección de dependencias.
import 'package:image_picker/image_picker.dart'; // Importa el paquete 'image_picker/image_picker.dart', que permite seleccionar imágenes desde la galería o la cámara.
import 'package:logger/logger.dart'; // Importa el paquete 'logger/logger.dart', que proporciona una utilidad de registro.
import 'package:path/path.dart' as path; // Importa el paquete 'path/path.dart' y lo alias como 'path' para manejar rutas de archivos.

class HomePage extends StatefulWidget {
  static String routeName = 'home'; // Nombre de la ruta de la página de inicio.

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _authenticationClient = GetIt.instance<AuthenticationClient>(); // Instancia del cliente de autenticación.
  final _accountApi = GetIt.instance<AccountApi>(); // Instancia de la API de la cuenta.
  final Logger _logger = Logger(); // Instancia del registrador de logs.
  User? _user; // Variable que almacena la información del usuario.

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadUser(); // Carga la información del usuario después del primer frame.
    });
  }

  Future<void> _loadUser() async {
    final response = await _accountApi.getUserInfo(); // Obtiene la información del usuario desde la API.
    if (response.data != null) {
      Logs.p.i(response.data!.createdAt); // Registra la fecha de creación del usuario.
      _user = response.data!; // Almacena la información del usuario.
      setState(() {}); // Notifica a la interfaz de usuario para que se actualice.
    }
  }

  Future<void> _signOut() async {
    _authenticationClient.signOut(); // Cierra sesión del usuario.
    Navigator.pushNamedAndRemoveUntil(
      context,
      LoginPage.routeName,
      (route) => false,
    ); // Navega a la página de inicio de sesión y elimina las demás rutas de la pila.
  }

  Future<void> _pickImage() async {
    final ImagePicker imagePicker = ImagePicker(); // Instancia del selector de imágenes.
    final pickedFile = await imagePicker.pickImage(source: ImageSource.camera); // Permite al usuario seleccionar una imagen de la cámara.
    if (pickedFile != null) {
      final Uint8List bytes = await pickedFile.readAsBytes(); // Lee los bytes de la imagen seleccionada.
      final filename = path.basename(pickedFile.path); // Obtiene el nombre del archivo de la imagen seleccionada.
      final response = await _accountApi.updateAvatar(bytes, filename); // Actualiza el avatar del usuario en la API.
      if (response != null) {
        _user = _user!.copyWith(avatar: response.data); // Actualiza el avatar del usuario localmente.
        final String imageUrl = 'http://192.168.137.1:9000${response.data}'; // Construye la URL del avatar actualizado.
        Logs.p.i(imageUrl); // Registra la URL del avatar actualizado.
        setState(() {}); // Notifica a la interfaz de usuario para que se actualice.
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_user == null) CircularProgressIndicator(), // Muestra un indicador de progreso si no se ha cargado la información del usuario.
            if (_user != null)
              Column(
                children: [
                  if (_user!.avatar != null)
                    ClipOval(
                      child: Image.network(
                          'http://192.168.137.1:9000${_user!.avatar}', // Muestra el avatar del usuario.
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                  Text(_user!.id), // Muestra el ID del usuario.
                  Text(_user!.email), // Muestra el correo electrónico del usuario.
                  Text(_user!.username), // Muestra el nombre de usuario del usuario.
                  Text(_user!.createdAt.toIso8601String()) // Muestra la fecha de creación del usuario.
                ],
              ),
            SizedBox(height: 30,), // Espacio vertical entre los elementos.
            ElevatedButton(
              onPressed: _pickImage, // Acción para actualizar el avatar.
              child: Text('Update avatar'), // Texto del botón para actualizar el avatar.
            ),
            ElevatedButton(
              onPressed: _signOut, // Acción para cerrar sesión.
              child: Text('Sign Out'), // Texto del botón para cerrar sesión.
            ),
          ],
        ),
      ),
    );
  }
}
