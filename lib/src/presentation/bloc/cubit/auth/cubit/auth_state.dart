import 'package:clickbuy/src/domain/entities/user_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_state.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial;
  const factory AuthState.loading() = _Loading;
  const factory AuthState.data({required UserEntity? user}) = _Data;
  const factory AuthState.error({required String message}) = _Error;
  const factory AuthState.singUp({@Default(false) bool isRegister}) = _Singup;
}
