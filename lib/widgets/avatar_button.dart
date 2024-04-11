import 'package:flutter/cupertino.dart'; // Importa el paquete 'flutter/cupertino.dart', que proporciona widgets específicos para la plataforma iOS de Flutter.
import 'package:flutter/material.dart'; // Importa el paquete 'flutter/material.dart', que proporciona widgets y herramientas para construir aplicaciones Flutter con diseño visual coherente.

class AvatarButton extends StatelessWidget {
  // Atributos de la clase AvatarButton
  final double imageSize; // Tamaño de la imagen del avatar.

  // Constructor de la clase AvatarButton
  const AvatarButton({
    super.key,
    this.imageSize = 100, // Establece un tamaño predeterminado para la imagen.
  });

  @override
  Widget build(BuildContext context) {
    return  Stack(
      children: [
        Container(
          margin: EdgeInsets.all(10), // Establece márgenes alrededor del contenedor.
          decoration: const BoxDecoration(
              color: Colors.white, // Establece el color de fondo del contenedor.
              shape: BoxShape.circle, // Establece la forma del contenedor como círculo.
              boxShadow: [ // Agrega una sombra al contenedor.
                BoxShadow(
                  blurRadius: 20, // Radio de desenfoque de la sombra.
                  color: Colors.black38, // Color de la sombra.
                  offset: Offset(0,20), // Desplazamiento de la sombra.
                ),
              ]
          ),
          child: ClipOval( // Recorta la imagen como un círculo.
            child: Image.network( // Muestra una imagen desde una URL.
              'https://cdn-icons-png.flaticon.com/512/147/147142.png', // URL de la imagen.
              width: imageSize, // Establece el ancho de la imagen.
              height: imageSize, // Establece la altura de la imagen.
            ),
          ),
        ),
        Positioned( // Posiciona el botón de Cupertino en una esquina del contenedor.
          bottom: 5, // Establece la distancia desde la parte inferior.
          right: 0, // Establece la distancia desde la derecha.
          child: CupertinoButton( // Botón específico de iOS de Cupertino.
            onPressed: () {  }, // Función llamada cuando se presiona el botón (sin acción definida aquí).
            padding: EdgeInsets.zero, // Establece el relleno del botón a cero.
            borderRadius: BorderRadius.circular(30), // Establece el radio de borde del botón.
            child: Container(
              padding: EdgeInsets.all(3), // Establece el relleno dentro del contenedor del botón.
              decoration: BoxDecoration(
                  border: Border.all( // Establece un borde alrededor del contenedor del botón.
                    color: Colors.white, // Color del borde.
                    width: 2, // Ancho del borde.
                  ),
                  color: Colors.pinkAccent, // Establece el color de fondo del contenedor del botón.
                  shape: BoxShape.circle // Establece la forma del contenedor del botón como círculo.
              ),
              child: Icon( // Icono dentro del contenedor del botón.
                Icons.add, // Ícono de más ('add').
                color: Colors.white, // Color del ícono.
              ),
            ),
          ),
        ),
      ],
    );
  }
}
