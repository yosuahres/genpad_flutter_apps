import 'package:application_genpad_local/features/auth/domain/entity/auth_user_entity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

extension AuthMapper on User {
  AuthUserEntity toUserEntity() {
    return AuthUserEntity(
      id: id,
      email: email!,
    );
  }
}
