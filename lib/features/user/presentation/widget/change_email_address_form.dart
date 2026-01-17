import 'package:flutter/material.dart';
import 'package:application_genpad_local/core/constants/spacings.dart';
import 'package:application_genpad_local/core/extensions/build_context_extensions.dart';
import 'package:application_genpad_local/core/widgets/form_wrapper.dart';
import 'package:application_genpad_local/features/user/presentation/widget/change_email_address_button.dart';
import 'package:application_genpad_local/features/user/presentation/widget/change_email_adress_email_input.dart';

class ChangeEmailAddressForm extends StatelessWidget {
  const ChangeEmailAddressForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FormWrapper(
      child: Align(
        alignment: Alignment(0, -1 / 3),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Change email address",
                style: context.textTheme.headlineLarge,
              ),
              SizedBox(height: Spacing.s16),
              Text(
                "You will be required to confirm an email change to new email address.",
                softWrap: true,
              ),
              SizedBox(height: Spacing.s16),
              ChangeEmailAddressEmailInput(),
              SizedBox(height: Spacing.s16),
              ChangeEmailAddressButton(),
            ],
          ),
        ),
      ),
    );
  }
}
