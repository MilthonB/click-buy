import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
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
              'error_message.network_timeout'.tr(),
            );
          case DioExceptionType.badResponse:
            final status = error.response?.statusCode;
            if (status == 401) return UnauthorizedException();
            if (status == 404) return NotFoundException();
            if (status == 500) return ServerException();
            return UnknownException(
              'error_message.unexpected_server'.tr(),
            );
          case DioExceptionType.cancel:
            return UnknownException('error_message.request_cancelled'.tr());
          case DioExceptionType.connectionError:
          case DioExceptionType.unknown:
            return NetworkException('error_message.network_connection'.tr());
          default:
            return UnknownException(error.message ?? 'unexpected_server'.tr());
        }
      }

      // === FIREBASE AUTH EXCEPTIONS ===
      if (error is FirebaseAuthException) {
        switch (error.code) {
          case 'user-not-found':
            return NotFoundException('error_message.user_not_found'.tr());
          case 'wrong-password':
            return UnauthorizedException('error_message.wrong_password'.tr());
          case 'email-already-in-use':
            return FirebaseAuthExceptionApp(
              'error_message.email_already_in_use'.tr(),
            );
          case 'invalid-email':
            return FirebaseAuthExceptionApp('error_message.invalid_email'.tr());
          case 'weak-password':
            return FirebaseAuthExceptionApp(
              'error_message.weak_password'.tr(),
            );
          case 'user-disabled':
            return UnauthorizedException('error_message.user_disabled'.tr());
          case 'operation-not-allowed':
            return FirebaseAuthExceptionApp(
              'error_message.operation_not_allowed'.tr(),
            );
          case 'account-exists-with-different-credential':
            return FirebaseAuthExceptionApp(
              'error_message.account_exists_with_different_credential'.tr(),
            );
          case 'error_message.invalid-credential':
            return FirebaseAuthExceptionApp(
              'error_message.invalid_credential'.tr(),
            );
          case 'invalid-verification-code':
            return FirebaseAuthExceptionApp('error_message.invalid_verification_code'.tr());
          case 'invalid-verification-id':
            return FirebaseAuthExceptionApp('error_message.invalid_verification_id'.tr());
          case 'network-request-failed':
            return NetworkException('error_message.network_request_failed'.tr());
          case 'too-many-requests':
            return FirebaseAuthExceptionApp(
              'error_message.too_many_requests'.tr(),
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
              'error_message.permission_denied'.tr(),
            );
          case 'not-found':
            return NotFoundException('error_message.document_not_found.tr()');
          case 'already-exists':
            return UnauthorizedException('error_message.document_already_exists'.tr());
          case 'resource-exhausted':
            return ServerException('error_message.resource_exhausted'.tr());
          case 'deadline-exceeded':
            return ServerException('error_message.deadline_exceeded'.tr());
          case 'aborted':
            return ServerException('error_message.operation_aborted'.tr());
          case 'out-of-range':
            return ServerException('error_message.out_of_range'.tr());
          case 'unimplemented':
            return ServerException('error_message.unimplemented'.tr());
          case 'internal':
            return ServerException('error_message.internal_error'.tr());
          case 'unavailable':
            return NetworkException('error_message.service_unavailable'.tr());
          case 'data-loss':
            return ServerException('error_message.data_loss'.tr());
          case 'unauthenticated':
            return UnauthorizedException('error_message.unauthenticated'.tr());
          default:
            return UnknownException(
              'Error de Firestore:',
            );
        }
      }
      // === SOCKET / INTERNET EXCEPTIONS ===
      if (error is SocketException) {
        return NetworkException('error_message.socket_error'.tr());
      }

      // === FORMAT EXCEPTIONS ===
      if (error is FormatException) {
        return UnknownException('error_message.format_error'.tr());
      }

      // === ALREADY IS AppException ===
      if (error is AppException) {
        return error;
      }

      // === UNEXPECTED ERROR ===
      return UnknownException(error.toString());
    } catch (e) {
      return UnknownException('error_message.error_processing_exception'.tr());
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
