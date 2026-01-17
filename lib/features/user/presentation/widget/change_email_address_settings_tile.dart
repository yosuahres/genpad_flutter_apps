import 'package:flutter/material.dart';
import 'package:application_genpad_local/core/router/routes.dart';
import 'package:application_genpad_local/features/settings/presentation/widget/settings_tile.dart';
import 'package:go_router/go_router.dart';

class ChangeEmailAddressSettingsTile extends StatelessWidget {
  const ChangeEmailAddressSettingsTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SettingsTile(
      leading: Icons.email,
      title: "Change email address",
      onTap: () => context.push(Routes.changeEmailAddress.path),
    );
  }
}
