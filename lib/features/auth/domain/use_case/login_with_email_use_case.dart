//login_with_email_use_case.dart
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import 'package:application_genpad_local/core/use_cases/use_case.dart';
import 'package:application_genpad_local/features/auth/domain/repository/auth_repository.dart';

@injectable
class LoginWithEmailUseCase extends UseCase<Future<void>, LoginWithEmailParams> {
  LoginWithEmailUseCase(
    this._authRepository,
  );

  final AuthRepository _authRepository;

  @override
  Future<void> execute(LoginWithEmailParams params) async {
    await _authRepository.loginWithEmailAndPassword(email: params.email, password: params.password);
  }
}

class LoginWithEmailParams extends Equatable {
  const LoginWithEmailParams({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;

  @override
  List<Object?> get props => [
        email,
        password
      ];
}
