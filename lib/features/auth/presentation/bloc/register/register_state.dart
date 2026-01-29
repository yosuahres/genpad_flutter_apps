part of 'register_cubit.dart';

class RegisterState extends Equatable {
  const RegisterState({
    this.email = const EmailValueObject.pure(),
    this.password = const PasswordValueObject.pure(), // Add this
    this.status = FormzSubmissionStatus.initial,
    this.isValid = false,
    this.errorMessage,
  });

  final EmailValueObject email;
  final PasswordValueObject password; // Add this
  final FormzSubmissionStatus status;
  final bool isValid;
  final String? errorMessage;

  RegisterState copyWith({
    EmailValueObject? email,
    PasswordValueObject? password, // Add this
    FormzSubmissionStatus? status,
    bool? isValid,
    String? errorMessage,
  }) {
    return RegisterState(
      email: email ?? this.email,
      password: password ?? this.password, // Add this
      status: status ?? this.status,
      isValid: isValid ?? this.isValid,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [email, password, status, isValid, errorMessage];
}