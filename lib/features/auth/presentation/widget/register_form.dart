//register_form.dart
import 'package:flutter/material.dart';
import 'package:application_genpad_local/core/constants/spacings.dart';
import 'package:application_genpad_local/core/extensions/build_context_extensions.dart';
import 'package:application_genpad_local/core/widgets/form_wrapper.dart';
import 'package:application_genpad_local/features/auth/presentation/widget/register_button.dart';
import 'package:application_genpad_local/features/auth/presentation/widget/register_email_input.dart';
import 'package:application_genpad_local/features/auth/presentation/widget/register_password_input.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FormWrapper(
      child: Center( 
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: Spacing.s24), 
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Create an Account!",
                  style: context.textTheme.displayLarge,
                  softWrap: true,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: Spacing.s8),
                Text(
                  "Please enter your email address to register.",
                  style: context.textTheme.displayMedium,
                  softWrap: true,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: Spacing.s48),
                const RegisterEmailInput(),
                const SizedBox(height: Spacing.s16),
                const RegisterPasswordInput(),
                const SizedBox(height: Spacing.s16),
                const RegisterButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}