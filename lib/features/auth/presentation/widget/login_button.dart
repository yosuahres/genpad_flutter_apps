//login_button.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart'; 
import 'package:application_genpad_local/core/router/routes.dart';
import 'package:application_genpad_local/core/extensions/build_context_extensions.dart';
import 'package:application_genpad_local/core/widgets/centered_circular_progress_indicator.dart';
import 'package:application_genpad_local/features/auth/presentation/bloc/login/login_cubit.dart';
import 'package:formz/formz.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.status.isFailure) {
          context.showErrorSnackBarMessage(state.errorMessage ?? 'Login failed');
        }
      },
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
            onPressed: state.isValid && !state.status.isInProgress
                ? () => context.read<LoginCubit>().submitForm()
                : null,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: state.status.isInProgress
                  ? const SizedBox(height: 24, width: 24, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                  : const Text("Login", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ),
        );
      },
    );
  }
}