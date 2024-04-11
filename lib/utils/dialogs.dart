import 'package:flutter/cupertino.dart'; // Importa el paquete 'flutter/cupertino.dart', que proporciona widgets específicos para la plataforma iOS de Flutter.
import 'package:flutter/material.dart'; // Importa el paquete 'flutter/material.dart', que proporciona widgets y herramientas para construir aplicaciones Flutter con diseño visual coherente.

// Clase abstracta Dialogs para mostrar alertas
abstract class Dialogs {
  // Método estático para mostrar una alerta
  static alert(
      BuildContext context, 
      {required String title,
       required String description}) {
    // Muestra un AlertDialog con el título y la descripción especificados
    showDialog(
      context: context, 
      builder: (_) => AlertDialog(
        title: Text(title), // Título de la alerta
        content: Text(description), // Descripción de la alerta
        actions: [
          ElevatedButton(
              onPressed: (){
                Navigator.pop(_); // Cierra la alerta al presionar el botón "OK"
              },
              child: Text('OK') // Texto del botón "OK"
          )
        ],
      )
    );
  }
}

// Clase abstracta ProgressDialog para mostrar un indicador de progreso
abstract class ProgressDialog {
  // Método estático para mostrar un indicador de progreso
  static show(BuildContext context) {
    // Muestra un PopScope con un indicador de progreso centrado
    showCupertinoModalPopup(
        context: context,
        builder: (_) {
          return PopScope(
            canPop: false,
            onPopInvoked: (didPop) {
              if (didPop) {
                // Aqui va ir al final
                return;
              }
              // Aqui va ir cuando se intente ir para atras
            },
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.white.withOpacity(0.9),
              child: const Center(
                child: CircularProgressIndicator(), // Indicador de progreso circular
              ),
            ),
          );
        }
    );
  }

  // Método estático para ocultar el indicador de progreso
  static dismiss(BuildContext context) {
    Navigator.pop(context); // Cierra el PopScope, ocultando el indicador de progreso
  }
}
