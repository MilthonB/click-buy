

import 'package:clickbuy/src/domain/entities/user_entity.dart';

abstract class LoginRepositories {

  
  Future<UserEntity> register({String email, String password, String name});
  Future<UserEntity> login({String email, String password});
  Future<void> logout();

  Stream<UserEntity?> authStateChange();

  Future<UserEntity?> getCurrentUser();




}