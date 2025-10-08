

import 'package:clickbuy/src/domain/entities/user_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserMapper {

  static UserEntity productModuleToEntity(User user) => UserEntity(
    id: user.uid,
    name: user.displayName ?? '',
    email: user.email ??''
  );

}


