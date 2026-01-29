//logout_use_case.dart
import 'package:injectable/injectable.dart';

import 'package:application_genpad_local/core/use_cases/no_params.dart';
import 'package:application_genpad_local/core/use_cases/use_case.dart';
import 'package:application_genpad_local/features/auth/domain/repository/auth_repository.dart';

@injectable
class LogoutUseCase extends UseCase<Future<void>, NoParams> {
  LogoutUseCase(
    this._authRepository,
  );

  final AuthRepository _authRepository;

  @override
  Future<void> execute(NoParams params) {
    return _authRepository.logout();
  }
}
