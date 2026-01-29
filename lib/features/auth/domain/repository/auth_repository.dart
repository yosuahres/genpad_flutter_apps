//auth_repository.dart
import '../entity/auth_user_entity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthRepository {
  Future<void> loginWithEmailAndPassword({required String email, required String password});
  Future<void> register({required String email, required String password});
  Future<void> logout();
  Stream<AuthState> getCurrentAuthState();
  AuthUserEntity? getLoggedInUser();
}
