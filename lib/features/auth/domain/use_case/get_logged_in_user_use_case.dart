//get_logged_in_user_use_case.dart
import 'package:injectable/injectable.dart';

import 'package:application_genpad_local/core/use_cases/no_params.dart';
import 'package:application_genpad_local/core/use_cases/use_case.dart';
import 'package:application_genpad_local/features/auth/domain/entity/auth_user_entity.dart';
import 'package:application_genpad_local/features/auth/domain/repository/auth_repository.dart';

@injectable
class GetLoggedInUserUseCase extends UseCase<AuthUserEntity?, NoParams> {
  GetLoggedInUserUseCase(
    this._authRepository,
  );

  final AuthRepository _authRepository;

  @override
  AuthUserEntity? execute(NoParams params) {
    return _authRepository.getLoggedInUser();
  }
}
