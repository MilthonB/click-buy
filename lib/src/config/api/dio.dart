import 'package:clickbuy/flavors/flavor_config.dart';
import 'package:clickbuy/src/config/helper/error_to_message.dart';
import 'package:dio/dio.dart';

class DioClient {

  static final DioClient _instance = DioClient._internal();
  factory DioClient() => _instance;

  late final Dio dio;

  DioClient._internal() {
    dio = Dio(
      BaseOptions(
        baseUrl: FlavorConfig.instance.baseUrl, 
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

    // late final String mensaje;

    final data = ErrorToMessage.mapErrorMessage(e);
    // switch (e.type) {
    //   case DioExceptionType.connectionError:
    //   throw 'Error de conexion';
    //   case DioExceptionType.connectionTimeout:
    //   case DioExceptionType.receiveTimeout:
    //   case DioExceptionType.sendTimeout:
    //     mensaje = "Tiempo de conexión agotado";
    //     break;
    //   case DioExceptionType.badResponse:
    //     final statusCode = e.response?.statusCode;
    //     if (statusCode == 401) {
    //       mensaje = "Sesión expirada. Inicia sesión de nuevo.";
    //     } else if (statusCode == 404) {
    //       mensaje = "Recurso no encontrado";
    //     } else if (statusCode == 500) {
    //       mensaje = "Error interno del servidor";
    //     } else {
    //       mensaje = "Error inesperado: Comunícate con el administrador de la aplicación";
    //     }
    //     break;
    //   case DioExceptionType.unknown:
    //     mensaje = "Error de conexión. Revisa tu internet.";
    //     break;
    //   default:
    //     mensaje = "Error inesperado: Comunícate con el administrador de la aplicación";
    //     break;
    // }

    // Lanzamos una Exception normal con mensaje
    // throw Exception(mensaje);

    throw data.message;
  },
));}

    DioClient.forTest(Dio dio) {
    this.dio = dio;
  }
}


