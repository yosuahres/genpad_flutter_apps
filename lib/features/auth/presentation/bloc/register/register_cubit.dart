//register_cubit.dart
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:injectable/injectable.dart';
import 'package:application_genpad_local/core/value_objects/email_value_object.dart';
import 'package:application_genpad_local/features/auth/domain/use_case/register_with_email_use_case.dart';
import 'package:application_genpad_local/core/value_objects/password_value_object.dart';

part 'register_state.dart';

@injectable
class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(this._registerWithEmailUseCase) : super(const RegisterState());

  final RegisterWithEmailUseCase _registerWithEmailUseCase;

  void emailChanged(String value) {
    final email = EmailValueObject.dirty(value);
    emit(state.copyWith(
      email: email,
      isValid: Formz.validate([email, state.password]), 
      status: FormzSubmissionStatus.initial,
    ));
  }

  void passwordChanged(String value) {
    final password = PasswordValueObject.dirty(value);
    emit(state.copyWith(
      password: password,
      isValid: Formz.validate([state.email, password]), 
      status: FormzSubmissionStatus.initial,
    ));
  }

  Future<void> register() async {
    if (!state.isValid) return;

    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    try {
      await _registerWithEmailUseCase.execute(
        RegisterWithEmailParams(
          email: state.email.value, 
          password: state.password.value,
          ),
      );
      emit(state.copyWith(status: FormzSubmissionStatus.success));
    } catch (e) {
      emit(state.copyWith(
        status: FormzSubmissionStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }
}