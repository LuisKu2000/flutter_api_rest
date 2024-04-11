import 'package:flutter/material.dart'; // Importa el paquete 'flutter/material.dart', que proporciona widgets y herramientas para construir aplicaciones Flutter con diseño visual coherente.
import 'dart:math' as math; // Importa el paquete 'dart:math' y lo asigna al alias 'math'.

class Responsive {
  // Atributos de la clase Responsive
  double _width = 0; // Ancho de la pantalla.
  double _height = 0; // Alto de la pantalla.
  double _diagonal = 0; // Longitud diagonal de la pantalla.
  bool _isTablet = false; // Indica si el dispositivo es una tableta.

  // Constructor de la clase Responsive
  Responsive(BuildContext context) {
    final Size size = MediaQuery.of(context).size; // Obtiene el tamaño de la pantalla a través de MediaQuery.
    _width = size.width; // Asigna el ancho de la pantalla.
    _height = size.height; // Asigna el alto de la pantalla.
    _diagonal = math.sqrt(math.pow(_width, 2) + math.pow(_height, 2)); // Calcula la longitud diagonal de la pantalla utilizando el teorema de Pitágoras.
    _isTablet = size.shortestSide >= 600; // Verifica si el lado más corto de la pantalla es mayor o igual a 600 (considerado como tamaño de tableta).
  }

  // Método estático para obtener una instancia de Responsive
  static Responsive of(BuildContext context) => Responsive(context);

  // Getters para obtener los valores de los atributos
  double get width => _width; // Devuelve el ancho de la pantalla.
  double get height => _height; // Devuelve el alto de la pantalla.
  double get diagonal => _diagonal; // Devuelve la longitud diagonal de la pantalla.
  bool get isTablet => _isTablet; // Devuelve un booleano indicando si el dispositivo es una tableta.

  // Métodos para calcular porcentajes relativos al tamaño de la pantalla
  double wp(double percent) => _width * percent / 100; // Calcula el ancho relativo a un porcentaje dado del ancho de la pantalla.
  double hp(double percent) => _height * percent / 100; // Calcula el alto relativo a un porcentaje dado del alto de la pantalla.
  double dp(double percent) => _diagonal * percent / 100; // Calcula la longitud diagonal relativa a un porcentaje dado de la longitud diagonal de la pantalla.
}
