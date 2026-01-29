//login_form.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:application_genpad_local/core/constants/spacings.dart';
import 'package:application_genpad_local/core/extensions/build_context_extensions.dart';
import 'package:application_genpad_local/features/auth/presentation/widget/login_button.dart';
import 'package:application_genpad_local/features/auth/presentation/widget/login_email_input.dart';
import 'package:application_genpad_local/core/router/routes.dart';
import 'package:application_genpad_local/features/auth/presentation/widget/login_password_input.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: Spacing.s32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Aesthetic Brand Icon
            Container(
              padding: const EdgeInsets.all(Spacing.s24),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.bolt_rounded,
                size: 48,
                color: Theme.of(context).primaryColor,
              ),
            ),
            const SizedBox(height: Spacing.s32),
            Text(
              "GenPad",
              style: context.textTheme.headlineLarge?.copyWith(
                fontWeight: FontWeight.w900,
                letterSpacing: -1,
              ),
            ),
            const SizedBox(height: Spacing.s8),
            Text(
              "Your workspace for creative generation.",
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.textTheme.bodyMedium?.color?.withOpacity(0.6),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: Spacing.s48),
            const LoginEmailInput(),
            const SizedBox(height: Spacing.s24),
            const LoginPasswordInput(),
            const SizedBox(height: Spacing.s32),
            const LoginButton(),
            const SizedBox(height: Spacing.s32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an account?"),
                TextButton(
                  onPressed: () => context.pushNamed(Routes.register.name),
                  child: const Text("Register", style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}