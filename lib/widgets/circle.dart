import 'package:flutter/material.dart'; // Importa el paquete 'flutter/material.dart', que proporciona widgets y herramientas para construir aplicaciones Flutter con diseño visual coherente.

class Circle extends StatelessWidget {
  // Atributos de la clase Circle
  final double size; // Tamaño del círculo.
  final List<Color> colors; // Lista de colores para el gradiente del círculo.

  // Constructor de la clase Circle
  const Circle({
    super.key,
    required this.size, // El tamaño debe ser obligatorio y no nulo.
    required this.colors, // Los colores deben ser obligatorios y no nulos.
  }): assert (size > 0), // Assert para asegurarse de que el tamaño sea mayor que cero.
      assert (colors.length >= 2); // Assert para asegurarse de que haya al menos dos colores en la lista.

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size, // Establece el ancho del contenedor.
      height: size, // Establece la altura del contenedor.
      decoration: BoxDecoration(
        shape: BoxShape.circle, // Establece la forma del contenedor como círculo.
        gradient: LinearGradient( // Crea un gradiente lineal para el fondo del círculo.
            colors: colors, // Establece los colores del gradiente.
            begin: Alignment.topCenter, // Define el punto de inicio del gradiente.
            end: Alignment.bottomCenter // Define el punto de finalización del gradiente.
        ),
      ),
    );
  }
}
