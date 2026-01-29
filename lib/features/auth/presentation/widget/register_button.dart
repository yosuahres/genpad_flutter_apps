// register_button.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:application_genpad_local/features/auth/presentation/bloc/register/register_cubit.dart';

import 'package:application_genpad_local/core/widgets/centered_circular_progress_indicator.dart';
import 'package:formz/formz.dart';

class RegisterButton extends StatelessWidget {
  const RegisterButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state.status == FormzSubmissionStatus.success) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Registration successful!')),
          );
          Navigator.pop(context);
        } else if (state.status == FormzSubmissionStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage ?? 'Error')),
          );
        }
      },
      builder: (context, state) {
        return state.status == FormzSubmissionStatus.inProgress
            ? const CenteredCircularProgressIndicator()
            : ElevatedButton(
                onPressed: state.isValid 
                ? () => context.read<RegisterCubit>().register()
                : null,
                child: const Text('Register'),
              );
      },
    );
  }
}