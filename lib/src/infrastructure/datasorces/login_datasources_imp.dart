import 'package:clickbuy/src/config/helper/error_to_message.dart';
import 'package:clickbuy/src/infrastructure/mappers/user_mapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:clickbuy/src/domain/datasources/login_datasources.dart';
import 'package:clickbuy/src/domain/entities/user_entity.dart';

class LoginDatasourcesImp implements LoginDatasources {
  final FirebaseAuth _auth = FirebaseAuth.instance;


  @override
  Stream<UserEntity?> authStateChange() {
    
    return _auth.authStateChanges().map(
      (user) => user == null ? null : UserMapper.productModuleToEntity(user)
    );
  }

  @override
  Future<UserEntity> login({
    String email = '',
    String password = '',
    String name = '',
  }) async {
    try {
      final userCred = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCred.user!;

      return UserMapper.productModuleToEntity(user);
    } on FirebaseAuthException catch (e) {
      throw ErrorToMessage.mapErrorMessage(e);
    }
  }

  @override
  Future<void> logout() async {
    await _auth.signOut();
  }

  @override
  Future<UserEntity> register({
    String email = '',
    String password = '',
    String name = '', // agregamos name
  }) async {
    // print(name);
    // return  UserEntity(id: 'id', email: 'email', name: 'name');

    try {
      final userCred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await userCred.user?.updateDisplayName(name);
      await userCred.user?.reload(); // refresca datos

      final user = userCred.user!;

      return UserMapper.productModuleToEntity(user);

    } on FirebaseAuthException catch (e) {
      throw ErrorToMessage.mapErrorMessage(e);
    }
  }

  @override
  Future<UserEntity?> getCurrentUser() async {
    final user = _auth.currentUser;
    if (user == null) return null;
    return UserMapper.productModuleToEntity(user);
  }
}
