//register_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:application_genpad_local/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:application_genpad_local/features/auth/presentation/bloc/register/register_cubit.dart';
import 'package:application_genpad_local/features/auth/presentation/widget/register_form.dart';
import 'package:application_genpad_local/core/router/routes.dart';
import 'package:application_genpad_local/dependency_injection.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthUserAuthenticated) {
          context.goNamed(Routes.home.name);
        }
      },
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Theme.of(context).colorScheme.surface,
                Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
              ],
            ),
          ),
          child: SafeArea(
            child: BlocProvider(
              create: (context) => getIt<RegisterCubit>(),
              child: const RegisterForm(),
            ),
          ),
        ),
      ),
    );
  }
}