class HttpResponse<T> {
  final T? data; // Datos de la respuesta.
  final HttpError? error; // Objeto de error en caso de que ocurra un error en la solicitud.

  // Constructor de la clase HttpResponse.
  HttpResponse(this.data, this.error);

  // Método estático para crear una instancia de HttpResponse en caso de éxito.
  static HttpResponse<T> success<T>(T data) => HttpResponse(data, null);

  // Método estático para crear una instancia de HttpResponse en caso de error.
  static HttpResponse<T> fail<T>({
    required int statusCode, // Código de estado del error.
    required String message, // Mensaje de error.
    required dynamic data // Datos relacionados con el error.
  }) => HttpResponse(null, HttpError(
        statusCode: statusCode,
        message: message,
        data: data,
      ));
}

class HttpError {
  final int statusCode; // Código de estado del error.
  final String message; // Mensaje de error.
  final dynamic data; // Datos relacionados con el error.

  // Constructor de la clase HttpError.
  HttpError({
    required this.statusCode,
    required this.message,
    required this.data,
  });
}
