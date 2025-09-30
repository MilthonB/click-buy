import 'package:dio/dio.dart';

class DioClient {
  // 🔹 Singleton
  static final DioClient _instance = DioClient._internal();
  factory DioClient() => _instance;

  late final Dio dio;

  // 🔹 Constructor privado
  DioClient._internal() {
    dio = Dio(
      BaseOptions(
        baseUrl: "https://dummyjson.com", // Cambia si usas otra API
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          "Content-Type": "application/json",
        },
      ),
    );

    // 🔹 Interceptors
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        // Agregar token si existe
        const token = "TOKEN_DE_EJEMPLO"; // TODO: reemplaza con secure storage/provider
        if (token.isNotEmpty) {
          options.headers["Authorization"] = "Bearer $token";
        }

        // print(
            // "➡️ [REQUEST] ${options.method} ${options.uri}\nHeaders: ${options.headers}\nData: ${options.data}");
        return handler.next(options);
      },
      onResponse: (response, handler) {
        // print(
            // "✅ [RESPONSE] ${response.statusCode} ${response.requestOptions.uri}\nData: ${response.data}");
        return handler.next(response);
      },
      onError: (DioException e, handler) {
        // print("❌ [ERROR] ${e.response?.statusCode} ${e.message}");

        switch (e.type) {
          case DioExceptionType.connectionTimeout:
          case DioExceptionType.receiveTimeout:
          case DioExceptionType.sendTimeout:
            throw Exception("⏱️ Tiempo de conexión agotado");
          case DioExceptionType.badResponse:
            final statusCode = e.response?.statusCode;
            if (statusCode == 401) {
              throw Exception("🔒 Sesión expirada. Inicia sesión de nuevo.");
            } else if (statusCode == 404) {
              throw Exception("🔎 Recurso no encontrado");
            } else if (statusCode == 500) {
              throw Exception("⚠️ Error interno del servidor");
            }
            break;
          case DioExceptionType.unknown:
            throw Exception("🌐 Error de conexión. Revisa tu internet.");
          default:
            throw Exception("🚨 Error inesperado: ${e.message}");
        }

        return handler.next(e);
      },
    ));
  }
}
