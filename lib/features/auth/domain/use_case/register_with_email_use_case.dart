//register_with_email_use_case.dart
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:application_genpad_local/core/use_cases/use_case.dart';
import 'package:application_genpad_local/features/auth/domain/repository/auth_repository.dart';

@injectable
class RegisterWithEmailUseCase extends UseCase<Future<void>, RegisterWithEmailParams> {
  RegisterWithEmailUseCase(this._authRepository);
  final AuthRepository _authRepository;

  @override
  Future<void> execute(RegisterWithEmailParams params) async {
    await _authRepository.register(email: params.email, password: params.password);
  }
}

class RegisterWithEmailParams extends Equatable {
  final String email;
  final String password;
  const RegisterWithEmailParams({required this.email, required this.password});
  @override
  List<Object?> get props => [email, password];
}