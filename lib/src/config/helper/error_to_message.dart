import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dio/dio.dart';

class ErrorToMessage {
  static AppException mapErrorMessage(dynamic error) {
    try {
      // === DIO EXCEPTIONS ===
      if (error is DioException) {
        switch (error.type) {
          case DioExceptionType.connectionTimeout:
          case DioExceptionType.sendTimeout:
          case DioExceptionType.receiveTimeout:
            return NetworkException(
              'Tiempo de conexión agotado. Revisa tu internet.',
            );
          case DioExceptionType.badResponse:
            final status = error.response?.statusCode;
            if (status == 401) return UnauthorizedException();
            if (status == 404) return NotFoundException();
            if (status == 500) return ServerException();
            return UnknownException(
              'Error inesperado del servidor (${status ?? 'sin código'}).',
            );
          case DioExceptionType.cancel:
            return UnknownException('La solicitud fue cancelada.');
          case DioExceptionType.connectionError:
          case DioExceptionType.unknown:
            return NetworkException('Error de conexión. Verifica tu internet.');
          default:
            return UnknownException(error.message ?? 'Error inesperado.');
        }
      }

      // === FIREBASE AUTH EXCEPTIONS ===
      if (error is FirebaseAuthException) {
        switch (error.code) {
          case 'user-not-found':
            return NotFoundException('Usuario no encontrado.');
          case 'wrong-password':
            return UnauthorizedException('Contraseña incorrecta.');
          case 'email-already-in-use':
            return FirebaseAuthExceptionApp(
              'El correo electrónico ya está registrado.',
            );
          case 'invalid-email':
            return FirebaseAuthExceptionApp('Correo electrónico inválido.');
          case 'weak-password':
            return FirebaseAuthExceptionApp(
              'La contraseña es demasiado débil.',
            );
          case 'user-disabled':
            return UnauthorizedException('La cuenta ha sido deshabilitada.');
          case 'operation-not-allowed':
            return FirebaseAuthExceptionApp(
              'Operación no permitida. Contacta al administrador.',
            );
          case 'account-exists-with-different-credential':
            return FirebaseAuthExceptionApp(
              'Ya existe una cuenta con diferentes credenciales.',
            );
          case 'invalid-credential':
            return FirebaseAuthExceptionApp(
              'Credencial inválida. Intenta iniciar sesión nuevamente.',
            );
          case 'invalid-verification-code':
            return FirebaseAuthExceptionApp('Código de verificación inválido.');
          case 'invalid-verification-id':
            return FirebaseAuthExceptionApp('ID de verificación inválido.');
          case 'network-request-failed':
            return NetworkException('Problema de conexión con Firebase.');
          case 'too-many-requests':
            return FirebaseAuthExceptionApp(
              'Demasiados intentos. Intenta más tarde.',
            );
          default:
            return FirebaseAuthExceptionApp(
              error.message ?? 'Error de autenticación.',
            );
        }
      }

      // === FIREBASE FIRESTORE EXCEPTIONS ===
      if (error is FirebaseException && error.plugin == 'cloud_firestore') {
        switch (error.code) {
          case 'permission-denied':
            return UnauthorizedException(
              'No tienes permiso para realizar esta acción.',
            );
          case 'not-found':
            return NotFoundException('Documento no encontrado.');
          case 'already-exists':
            return UnauthorizedException('El documento ya existe.');
          case 'resource-exhausted':
            return ServerException('Se ha agotado el recurso.');
          case 'deadline-exceeded':
            return ServerException('Se ha superado el tiempo límite.');
          case 'aborted':
            return ServerException('La operación fue abortada.');
          case 'out-of-range':
            return ServerException('Valor fuera de rango.');
          case 'unimplemented':
            return ServerException('Operación no implementada.');
          case 'internal':
            return ServerException('Error interno del servidor.');
          case 'unavailable':
            return NetworkException('Servicio de Firestore no disponible.');
          case 'data-loss':
            return ServerException('Pérdida de datos.');
          case 'unauthenticated':
            return UnauthorizedException('No autenticado.');
          default:
            return UnknownException(
              'Error de Firestore: ${error.message ?? 'desconocido'}.',
            );
        }
      }
      // === SOCKET / INTERNET EXCEPTIONS ===
      if (error is SocketException) {
        return NetworkException('Sin conexión a internet.');
      }

      // === FORMAT EXCEPTIONS ===
      if (error is FormatException) {
        return UnknownException('Error al procesar los datos.');
      }

      // === ALREADY IS AppException ===
      if (error is AppException) {
        return error;
      }

      // === UNEXPECTED ERROR ===
      return UnknownException(error.toString());
    } catch (e, s) {
      return UnknownException('Error al procesar la excepción. veririfica con soporte');
    }
  }
}



abstract class AppException implements Exception {
  final String message;
  AppException([this.message = 'Ocurrió un error']);
  @override
  String toString() => message;
}

class NetworkException extends AppException {
  NetworkException([String message = 'No hay conexión a internet'])
    : super(message);
}

class UnauthorizedException extends AppException {
  UnauthorizedException([String message = 'Sesión expirada']) : super(message);
}

class NotFoundException extends AppException {
  NotFoundException([String message = 'Recurso no encontrado'])
    : super(message);
}

class ServerException extends AppException {
  ServerException([String message = 'Error interno del servidor'])
    : super(message);
}

class FirebaseAuthExceptionApp extends AppException {
  FirebaseAuthExceptionApp([String message = 'Error de autenticación'])
    : super(message);
}

class UnknownException extends AppException {
  UnknownException([String message = 'Error inesperado']) : super(message);
}
