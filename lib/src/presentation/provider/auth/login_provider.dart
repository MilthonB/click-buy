import 'dart:io';

import 'package:clickbuy/src/domain/datasources/login_datasources.dart';
import 'package:clickbuy/src/domain/entities/user_entity.dart';
import 'package:clickbuy/src/domain/repositories/login_repositories.dart';
import 'package:clickbuy/src/infrastructure/datasorces/login_datasources_imp.dart';
import 'package:clickbuy/src/infrastructure/repositories/login_repositorie_imp.dart';
import 'package:clickbuy/src/presentation/provider/cart/cart_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'login_provider.g.dart';

@riverpod
LoginRepositories loginRepositorie(ref) {
  return LoginRepositorieImp(LoginDatasourcesImp());
}

@Riverpod(keepAlive: true)
class Register extends _$Register {
  @override
  Future<UserEntity?> build() async {
   
    return Future.value(null);
  }

  Future<void> signUp({
  required String email,
  required String password,
  required String name
}) async {

  state = const AsyncLoading(); // Indica que estamos cargando

    final repo = ref.read(loginRepositorieProvider);

    try {
      final user = await repo.register(email: email, password: password, name: name);

      if (!ref.mounted) return;

      state = AsyncData(user); // Login exitoso

    } on FirebaseAuthException catch (e) {
      if (!ref.mounted) return;

      // Mapear códigos de Firebase a mensajes amigables
      String message;
      switch (e.code) {
        case 'invalid-email': message = 'Correo inválido'; break;
        case 'weak-password': message = 'La contraseña debe ser mayor a 6 carcateres'; break;
        case 'email-already-in-use': message = 'Email ya registrado, ingresa uno nuevo'; break;
        default: message = e.message ?? 'Error de autenticación';
      }

      state = AsyncError(message, StackTrace.current); // Captura el error en el estado

    } catch (e, st) {
      if (!ref.mounted) return;
      state = AsyncError('Error inesperado', st); // Cualquier otro error
    }




}

}



@riverpod
class TotalItems extends _$TotalItems {
  @override
  Future<int> build(String userId) {
    return ref.read(cartProvider.notifier).getTotalItems(userId);
  }
}


@Riverpod(keepAlive: true)
class Login extends _$Login {
  @override
  Future<UserEntity?> build() async {

    final repo = ref.read(loginRepositorieProvider);
    return await repo.getCurrentUser();

    // return null; // Al inicio no hay usuario registrado
  }

  UserEntity? getUser(){
    return state.value;
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    state = const AsyncLoading(); // Indica que estamos cargando

    final repo = ref.read(loginRepositorieProvider);

    try {
      final user = await repo.login(email: email, password: password);

      if (!ref.mounted) return;

      state = AsyncData(user); // Login exitoso

    } on FirebaseAuthException catch (e) {
      if (!ref.mounted) return;

      // Mapear códigos de Firebase a mensajes amigables
      String message;
      switch (e.code) {
        case 'invalid-credential': message = 'Correo o contraseña inválido'; break;
        case 'invalid-email': message = 'Correo inválido'; break;
        case 'user-not-found': message = 'Usuario no encontrado'; break;
        case 'wrong-password': message = 'Contraseña incorrecta'; break;
        default: message = e.message ?? 'Error de autenticación';
      }

      state = AsyncError(message, StackTrace.current); // Captura el error en el estado

    } on SocketException catch (_) {
      if (!ref.mounted) return;
      state = AsyncError('Sin conexión a internet', StackTrace.current);

    }catch (e, st) {
      if (!ref.mounted) return;
      state = AsyncError('Error inesperado', st); // Cualquier otro error
    }
  }

  Future<void> logout() async{
    final datasources = ref.read(loginRepositorieProvider);
    await datasources.logout();
    state = const AsyncData(null); 
  }


}


