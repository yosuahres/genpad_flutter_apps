import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:application_genpad_local/core/router/router.dart';
import 'package:application_genpad_local/core/app/app_theme.dart';
import 'package:application_genpad_local/dependency_injection.dart';
import 'package:application_genpad_local/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:application_genpad_local/features/theme_mode/presentation/bloc/theme_mode_cubit.dart';

class FlutterSupabaseStarterApp extends StatelessWidget {
  const FlutterSupabaseStarterApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _AppBlocProvider(
      child: BlocBuilder<ThemeModeCubit, ThemeModeState>(
        buildWhen: (previous, current) => previous.selectedThemeMode != current.selectedThemeMode,
        builder: (context, state) {
          return MaterialApp.router(
            title: 'Flutter and Supabase Starter',
            routerConfig: router,
            debugShowCheckedModeBanner: false,
            theme: theme,
            darkTheme: darkTheme,
            themeMode: state.selectedThemeMode,
          );
        },
      ),
    );
  }
}

class _AppBlocProvider extends StatelessWidget {
  const _AppBlocProvider({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) => getIt<AuthBloc>()
              ..add(
                const AuthInitialCheckRequested(),
              )),
        BlocProvider(
          create: (_) => getIt<ThemeModeCubit>()..getCurrentTheme(),
        ),
      ],
      child: child,
    );
  }
}
