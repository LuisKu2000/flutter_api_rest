import 'package:logger/logger.dart'; // Importa el paquete 'logger/logger.dart', que proporciona herramientas para el registro de mensajes de registro.

class Logs {
  // Constructor privado para evitar la creación de instancias de forma externa.
  Logs._internal();

  // Instancia única de la clase Logs.
  static final Logs _instance = Logs._internal();

  // Logger utilizado para el registro de mensajes.
  final Logger _logger = Logger();

  // Método estático para obtener la instancia única de Logs.
  static Logs get instance => _instance;

  // Getter estático para obtener el logger.
  static Logger get p => _instance._logger;
}
