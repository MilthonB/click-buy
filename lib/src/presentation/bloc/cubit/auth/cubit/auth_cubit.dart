import 'package:clickbuy/src/domain/entities/user_entity.dart';
import 'package:clickbuy/src/domain/repositories/login_repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginRepositories _repository;

  AuthCubit(this._repository) : super(AuthState.initial());

  Future<void> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    emit(AuthState.loading());
    try {
      await _repository.register(
        email: email,
        password: password,
        name: name,
      );
      if (isClosed) return;
      emit(AuthState.singUp(isRegister: true));
    } catch (e) {
      if (isClosed) return;
      emit(AuthState.error(message: e.toString()));
    }
  }

  Future<void> login({required String email, required String password}) async {
    emit(AuthState.loading());
    try {
      final user = await _repository.login(email: email, password: password);
      if (isClosed) return;
      emit(AuthState.data(user: user));
      // cargar el carrito
      
    } catch (e) {
      if (isClosed) return;
      emit(AuthState.error(message: e.toString()));
    }
  }


  Future<void> checkSession() async {
  emit(AuthState.loading());
  try {
    final user = await _repository.getCurrentUser();
    emit(AuthState.data(user: user));
  } catch (e) {
    emit(AuthState.error(message: 'Error al verificar sesión'));
  }
}


  Future<void> logout() async {
    emit(AuthState.loading());

    try {
      await _repository.logout();

      if (isClosed) return;

      emit(AuthState.data(user: null));
    } catch (e) {
      emit(AuthState.error(message: e.toString()));
    }
  }


  UserEntity? getUser() {
    return state.maybeWhen(
      data: (user) {
        return user;
      },
      orElse: () => null,
    );
  }
}
