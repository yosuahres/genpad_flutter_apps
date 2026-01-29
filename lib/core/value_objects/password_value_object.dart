//password_value_object.dart
import 'package:formz/formz.dart';

enum PasswordValidationError { 
  tooShort,
  empty 
}

class PasswordValueObject extends FormzInput<String, PasswordValidationError> {
  const PasswordValueObject.pure() : super.pure('');

  const PasswordValueObject.dirty([super.value = '']) : super.dirty();

  @override
  PasswordValidationError? validator(String value) {
    if (value.isEmpty) {
      return PasswordValidationError.empty;
    }
    return value.length >= 6 
        ? null 
        : PasswordValidationError.tooShort;
  }
}