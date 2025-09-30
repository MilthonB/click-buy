

import 'package:clickbuy/src/domain/datasources/login_datasources.dart';
import 'package:clickbuy/src/domain/entities/user_entity.dart';
import 'package:clickbuy/src/domain/repositories/login_repositories.dart';

class LoginRepositorieImp implements LoginRepositories{

  final LoginDatasources datasources;

  LoginRepositorieImp(this.datasources);

  @override
  Stream<UserEntity?> authStateChange()  {
    return datasources.authStateChange();
  }

  @override
  Future<UserEntity> login({String email = '', String password = ''}) {
    return datasources.login( email: email, password: password);
  }

  @override
  Future<void> logout(){
    return datasources.logout();
  }

  @override
  Future<UserEntity> register({String email = '', String password = '', String name = ''})  {
    return datasources.register( email: email, password: password, name: name);
  }
  
  @override
  Future<UserEntity?> getCurrentUser() {
    return datasources.getCurrentUser();
  }
}