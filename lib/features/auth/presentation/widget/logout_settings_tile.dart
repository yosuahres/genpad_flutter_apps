//logout_settings_tile.dart
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:application_genpad_local/core/router/routes.dart";
import "package:application_genpad_local/core/utils/dialog_utils.dart";
import "package:application_genpad_local/features/auth/presentation/bloc/auth_bloc.dart";
import "package:go_router/go_router.dart";

import "../../../../core/constants/colors.dart";

class LogoutSettingsTile extends StatelessWidget {
  const LogoutSettingsTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: () => _showLogOutConfirmationDialog(context),
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.red.withOpacity(0.1)),
            borderRadius: BorderRadius.circular(16),
            color: Colors.red.withOpacity(0.05),
          ),
          child: const Row(
            children: [
              Icon(Icons.logout_rounded, color: Colors.red),
              SizedBox(width: 16),
              Text("Logout", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
              Spacer(),
              Icon(Icons.arrow_forward_ios_rounded, size: 14, color: Colors.red),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showLogOutConfirmationDialog(
    BuildContext context,
  ) async {
    final confirmed = await DialogUtils.showConfirmationDialog(
      context,
      title: "Logout",
      message: "Are you sure you want to logout?",
      confirmText: "Logout",
    );

    if (confirmed && context.mounted) {
      context.read<AuthBloc>().add(const AuthLogoutButtonPressed());
      context.go(Routes.login.path);
    }
  }
}
