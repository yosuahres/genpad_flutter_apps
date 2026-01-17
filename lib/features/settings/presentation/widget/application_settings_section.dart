import 'package:flutter/material.dart';
import 'package:application_genpad_local/features/settings/presentation/widget/settings_section.dart';
import 'package:application_genpad_local/features/theme_mode/presentation/widget/theme_mode_settings_tile.dart';

class ApplicationSettingsSection extends StatelessWidget {
  const ApplicationSettingsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const SettingsSection(
      title: "Application",
      items: [
        ThemeModeSettingsTile(),
      ],
    );
  }
}
