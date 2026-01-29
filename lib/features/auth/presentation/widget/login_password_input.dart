// login_password_input.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:application_genpad_local/features/auth/presentation/bloc/login/login_cubit.dart';

class LoginPasswordInput extends StatefulWidget {
  const LoginPasswordInput({super.key});

  @override
  State<LoginPasswordInput> createState() => _LoginPasswordInputState();
}

class _LoginPasswordInputState extends State<LoginPasswordInput> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          onChanged: (password) => context.read<LoginCubit>().passwordChanged(password),
          obscureText: _obscureText,
          decoration: InputDecoration(
            hintText: "Password",
            prefixIcon: const Icon(Icons.lock_outline_rounded),
            suffixIcon: IconButton(
              icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
              onPressed: () => setState(() => _obscureText = !_obscureText),
            ),
            filled: true,
            fillColor: Theme.of(context).colorScheme.surface,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
            errorText: state.password.displayError != null ? "Password too short" : null,
          ),
        );
      },
    );
  }
}