import 'package:firebase_auth/firebase_auth.dart';
import 'package:clickbuy/src/domain/datasources/login_datasources.dart';
import 'package:clickbuy/src/domain/entities/user_entity.dart';

class LoginDatasourcesImp implements LoginDatasources {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserEntity _mapFirebaseUser(User user) {
    return UserEntity(
      id: user.uid,
      email: user.email ?? '',
      name: user.displayName ?? '',
    );
  }

  @override
  Stream<UserEntity?> authStateChange() {
    return _auth.authStateChanges().map(
      (user) => user == null ? null : _mapFirebaseUser(user),
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

      return _mapFirebaseUser(userCred.user!);
    } on FirebaseAuthException catch (e) {
      throw e;
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

      return _mapFirebaseUser(userCred.user!);
    } on FirebaseAuthException catch (e) {
      throw e;
    }
  }

  @override
  Future<UserEntity?> getCurrentUser() async {
    final user = _auth.currentUser;
    if (user == null) return null;
    return UserEntity(
      id: user.uid,
      email: user.email!,
      name: user.displayName!,
    );
  }
}
