//supabase_auth_repository.dart
import 'package:flutter/foundation.dart';
import 'package:application_genpad_local/core/constants/urls.dart';
import 'package:application_genpad_local/features/auth/data/mapper/auth_mapper.dart';
import 'package:application_genpad_local/features/auth/domain/entity/auth_user_entity.dart';
import 'package:application_genpad_local/features/auth/domain/exception/login_with_email_exception.dart';
import 'package:application_genpad_local/features/auth/domain/repository/auth_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@Injectable(as: AuthRepository)
class SupabaseAuthRepository implements AuthRepository {
  SupabaseAuthRepository(
    this._supabaseAuth,
  );

  final GoTrueClient _supabaseAuth;

  @override
  Future<void> loginWithEmailAndPassword({required String email, required String password}) async {
    try {
      await _supabaseAuth.signInWithPassword(
        email: email,
        password: password,
      );
    } on AuthException catch (error) {
      throw LoginWithEmailException(error.message);
    }
  }

  @override
  Future<void> register({required String email, required String password}) async {
    try {
      await _supabaseAuth.signUp(
        email: email,
        password: password,
      );
    } on AuthException catch (error) {
      throw Exception(error.message);
    }
  }

  @override
  Future<void> logout() async {
    await _supabaseAuth.signOut();
  }

  @override
  Stream<AuthState> getCurrentAuthState() {
    return _supabaseAuth.onAuthStateChange.map(
      (authState) => authState,
    );
  }

  @override
  AuthUserEntity? getLoggedInUser() {
    return _supabaseAuth.currentUser?.toUserEntity();
  }
}