import 'package:dio/dio.dart'; // Importación de la librería Dio para realizar solicitudes HTTP.
import 'package:flutter_api_rest/helpers/http_response.dart'; // Importación de la clase HttpResponse para manejar la respuesta de la solicitud HTTP.
import 'package:flutter_api_rest/utils/logs.dart'; // Importación de la clase Logs para el registro de logs.

class Http {
  late Dio _dio; // Instancia de la clase Dio para realizar solicitudes HTTP.
  late bool _logsEnable; // Booleano que indica si los registros de logs están habilitados.

  // Constructor de la clase Http.
  Http({
    required Dio dio, // Objeto de la clase Dio requerido para realizar solicitudes HTTP.
    required bool logsEnable, // Booleano que indica si los registros de logs están habilitados.
  }) {
    _dio = dio; // Asignación del objeto Dio proporcionado al atributo _dio.
    _logsEnable = logsEnable; // Asignación del valor de logsEnable al atributo _logsEnable.
  }

  // Método para realizar una solicitud HTTP.
  Future<HttpResponse<T>> request<T>(
    String path, {
    String method = 'GET', // Método de solicitud HTTP, por defecto es GET.
    Map<String, dynamic>? queryParameters, // Parámetros de la consulta de la solicitud HTTP.
    Map<String, dynamic>? data, // Datos de la solicitud HTTP.
    Map<String, dynamic>? formData, // Datos de formulario de la solicitud HTTP.
    Map<String, dynamic>? headers, // Cabeceras de la solicitud HTTP.
    T Function(dynamic data)? parser, // Función para analizar los datos de la respuesta HTTP.
  }) async {
    try {
      // Realizar la solicitud HTTP utilizando el método request de la clase Dio.
      final response = await _dio.request(
        path,
        options: Options(
          method: method,
          headers: headers,
        ),
        queryParameters: queryParameters,
        data: formData != null? FormData.fromMap(formData) : data,
      );
      Logs.p.i(response.data); // Registrar los datos de la respuesta si los registros de logs están habilitados.

      // Comprobar si se proporcionó una función de análisis.
      if (parser != null) {
        // Devolver una HttpResponse con éxito y los datos analizados.
        return HttpResponse.success<T>(parser(response.data));
      }

      // Devolver una HttpResponse con éxito y los datos de la respuesta.
      return HttpResponse.success<T>(response.data);
    } catch (e) {
      Logs.p.e(e); // Registrar el error si los registros de logs están habilitados.

      int statusCode = 0; // Código de estado de la respuesta HTTP.
      String message = 'unknown error'; // Mensaje de error predeterminado.
      dynamic data; // Datos de la respuesta HTTP.

      // Comprobar si se produjo un error de tipo DioError.
      if (e is DioError) {
        statusCode = -1; // Establecer un código de estado predeterminado.
        message = e.message.toString(); // Obtener el mensaje de error.
        // Comprobar si hay una respuesta válida en el error.
        if (e.response != null) {
          statusCode = e.response!.statusCode!; // Obtener el código de estado de la respuesta.
          message = e.response!.statusMessage!; // Obtener el mensaje de estado de la respuesta.
          data = e.response!.data; // Obtener los datos de la respuesta.
        }
      }
      // Devolver una HttpResponse con error y los detalles del error.
      return HttpResponse.fail(
        statusCode: statusCode,
        message: message,
        data: data,
      );
    }
  }
}
