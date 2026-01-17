import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:application_genpad_local/core/extensions/build_context_extensions.dart';
import 'package:application_genpad_local/core/widgets/centered_circular_progress_indicator.dart';
import 'package:application_genpad_local/features/user/presentation/bloc/change_email_address/change_email_address_cubit.dart';
import 'package:formz/formz.dart';

class ChangeEmailAddressButton extends StatelessWidget {
  const ChangeEmailAddressButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChangeEmailAddressCubit, ChangeEmailAddressState>(
      builder: (context, state) {
        return state.status.isInProgress
            ? const CenteredCircularProgressIndicator()
            : ElevatedButton(
                onPressed: state.isValid
                    ? () {
                        context.closeKeyboard();
                        context.read<ChangeEmailAddressCubit>().submitForm();
                      }
                    : null,
                child: const Text('Send instructions'),
              );
      },
    );
  }
}
