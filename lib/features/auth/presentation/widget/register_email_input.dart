//register_email_input.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:application_genpad_local/features/auth/presentation/bloc/register/register_cubit.dart';
import 'package:application_genpad_local/core/widgets/email_text_field.dart';

class RegisterEmailInput extends StatelessWidget {
  const RegisterEmailInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return EmailTextField( // Use your custom widget like in login
          onChanged: (email) => context.read<RegisterCubit>().emailChanged(email),
          textInputAction: TextInputAction.next,
          errorText: state.email.displayError != null ? "Invalid email address" : null,
        );
      },
    );
  }
}