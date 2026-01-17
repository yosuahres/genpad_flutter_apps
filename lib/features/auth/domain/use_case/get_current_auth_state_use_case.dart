import 'package:injectable/injectable.dart';

import 'package:application_genpad_local/core/use_cases/no_params.dart';
import 'package:application_genpad_local/core/use_cases/use_case.dart';
import 'package:application_genpad_local/features/auth/domain/entity/auth_user_entity.dart';
import 'package:application_genpad_local/features/auth/domain/repository/auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@injectable
class GetCurrentAuthStateUseCase extends UseCase<Stream<AuthState>, NoParams> {
  GetCurrentAuthStateUseCase(
    this._authRepository,
  );

  final AuthRepository _authRepository;

  @override
  Stream<AuthState> execute(NoParams params) {
    return _authRepository.getCurrentAuthState();
  }
}
