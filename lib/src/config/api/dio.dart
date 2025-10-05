import 'package:dio/dio.dart';

class DioClient {

  static final DioClient _instance = DioClient._internal();
  factory DioClient() => _instance;

  late final Dio dio;

  DioClient._internal() {
    dio = Dio(
      BaseOptions(
        baseUrl: "https://dummyjson.com", 
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          "Content-Type": "application/json",
        },
      ),
    );


    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        const token = "Token"; 
        if (token.isNotEmpty) {
          options.headers["Authorization"] = "Bearer $token";
        }
        return handler.next(options);
      },
      onResponse: (response, handler) {
        return handler.next(response);
      },
      onError: (DioException e, handler) {

        switch (e.type) {
          case DioExceptionType.connectionTimeout:
          case DioExceptionType.receiveTimeout:
          case DioExceptionType.sendTimeout:
            throw Exception("Tiempo de conexión agotado");
          case DioExceptionType.badResponse:
            final statusCode = e.response?.statusCode;
            if (statusCode == 401) {
              throw Exception("Sesión expirada. Inicia sesión de nuevo.");
            } else if (statusCode == 404) {
              throw Exception("Recurso no encontrado");
            } else if (statusCode == 500) {
              throw Exception("Error interno del servidor");
            }
            break;
          case DioExceptionType.unknown:
            throw Exception("Error de conexión. Revisa tu internet.");
          default:
            throw Exception("Error inesperado: ${e.message}");
        }

        return handler.next(e);
      },
    ));
  }

    DioClient.forTest(Dio dio) {
    this.dio = dio;
  }
}


