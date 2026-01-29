// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:application_genpad_local/core/app/app_module.dart' as _i850;
import 'package:application_genpad_local/features/auth/data/repository/supabase_auth_repository.dart'
    as _i491;
import 'package:application_genpad_local/features/auth/domain/repository/auth_repository.dart'
    as _i483;
import 'package:application_genpad_local/features/auth/domain/use_case/get_current_auth_state_use_case.dart'
    as _i718;
import 'package:application_genpad_local/features/auth/domain/use_case/get_logged_in_user_use_case.dart'
    as _i107;
import 'package:application_genpad_local/features/auth/domain/use_case/login_with_email_use_case.dart'
    as _i432;
import 'package:application_genpad_local/features/auth/domain/use_case/logout_use_case.dart'
    as _i551;
import 'package:application_genpad_local/features/auth/domain/use_case/register_with_email_use_case.dart'
    as _i403;
import 'package:application_genpad_local/features/auth/presentation/bloc/auth_bloc.dart'
    as _i1046;
import 'package:application_genpad_local/features/auth/presentation/bloc/login/login_cubit.dart'
    as _i282;
import 'package:application_genpad_local/features/auth/presentation/bloc/register/register_cubit.dart'
    as _i374;
import 'package:application_genpad_local/features/home/presentation/bloc/bottom_navigation_bar/bottom_navigation_bar_cubit.dart'
    as _i343;
import 'package:application_genpad_local/features/report/data/repository/report_repository.dart'
    as _i963;
import 'package:application_genpad_local/features/report/domain/use_cases/upload_report_use_case.dart'
    as _i350;
import 'package:application_genpad_local/features/theme_mode/data/repository/theme_mode_hive_repository.dart'
    as _i480;
import 'package:application_genpad_local/features/theme_mode/domain/repository/theme_mode_repository.dart'
    as _i952;
import 'package:application_genpad_local/features/theme_mode/domain/use_case/get_or_set_initial_theme_mode_use_case.dart'
    as _i745;
import 'package:application_genpad_local/features/theme_mode/domain/use_case/set_theme_mode_id_use_case.dart'
    as _i638;
import 'package:application_genpad_local/features/theme_mode/presentation/bloc/theme_mode_cubit.dart'
    as _i290;
import 'package:application_genpad_local/features/user/data/repository/supabase_user_repository.dart'
    as _i201;
import 'package:application_genpad_local/features/user/domain/repository/user_repository.dart'
    as _i669;
import 'package:application_genpad_local/features/user/domain/use_case/change_email_address_use_case.dart'
    as _i136;
import 'package:application_genpad_local/features/user/presentation/bloc/change_email_address/change_email_address_cubit.dart'
    as _i551;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:supabase/supabase.dart' as _i590;
import 'package:supabase_flutter/supabase_flutter.dart' as _i454;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final appModule = _$AppModule();
    gh.factory<_i454.SupabaseClient>(() => appModule.supabaseClient);
    gh.factory<_i454.GoTrueClient>(() => appModule.supabaseAuth);
    gh.factory<_i454.FunctionsClient>(() => appModule.functionsClient);
    gh.factory<_i343.BottomNavigationBarCubit>(
        () => _i343.BottomNavigationBarCubit());
    gh.factory<_i952.ThemeModeRepository>(
        () => _i480.ThemeModeHiveRepository());
    gh.factory<_i669.UserRepository>(() => _i201.SupabaseUserRepository(
          gh<_i590.GoTrueClient>(),
          gh<_i590.FunctionsClient>(),
        ));
    gh.factory<_i483.AuthRepository>(
        () => _i491.SupabaseAuthRepository(gh<_i454.GoTrueClient>()));
    gh.factory<_i745.GetOrSetInitialThemeModeUseCase>(() =>
        _i745.GetOrSetInitialThemeModeUseCase(gh<_i952.ThemeModeRepository>()));
    gh.factory<_i638.SetThemeModeUseCase>(
        () => _i638.SetThemeModeUseCase(gh<_i952.ThemeModeRepository>()));
    gh.factory<_i963.ReportRepository>(
        () => _i963.ReportRepository(gh<_i454.SupabaseClient>()));
    gh.factory<_i290.ThemeModeCubit>(() => _i290.ThemeModeCubit(
          gh<_i745.GetOrSetInitialThemeModeUseCase>(),
          gh<_i638.SetThemeModeUseCase>(),
        ));
    gh.factory<_i551.LogoutUseCase>(
        () => _i551.LogoutUseCase(gh<_i483.AuthRepository>()));
    gh.factory<_i107.GetLoggedInUserUseCase>(
        () => _i107.GetLoggedInUserUseCase(gh<_i483.AuthRepository>()));
    gh.factory<_i432.LoginWithEmailUseCase>(
        () => _i432.LoginWithEmailUseCase(gh<_i483.AuthRepository>()));
    gh.factory<_i718.GetCurrentAuthStateUseCase>(
        () => _i718.GetCurrentAuthStateUseCase(gh<_i483.AuthRepository>()));
    gh.factory<_i403.RegisterWithEmailUseCase>(
        () => _i403.RegisterWithEmailUseCase(gh<_i483.AuthRepository>()));
    gh.factory<_i1046.AuthBloc>(() => _i1046.AuthBloc(
          gh<_i107.GetLoggedInUserUseCase>(),
          gh<_i718.GetCurrentAuthStateUseCase>(),
          gh<_i551.LogoutUseCase>(),
        ));
    gh.factory<_i350.UploadReportUseCase>(
        () => _i350.UploadReportUseCase(gh<_i963.ReportRepository>()));
    gh.factory<_i136.ChangeEmailAddressUseCase>(
        () => _i136.ChangeEmailAddressUseCase(gh<_i669.UserRepository>()));
    gh.factory<_i374.RegisterCubit>(
        () => _i374.RegisterCubit(gh<_i403.RegisterWithEmailUseCase>()));
    gh.factory<_i282.LoginCubit>(
        () => _i282.LoginCubit(gh<_i432.LoginWithEmailUseCase>()));
    gh.factory<_i551.ChangeEmailAddressCubit>(() =>
        _i551.ChangeEmailAddressCubit(gh<_i136.ChangeEmailAddressUseCase>()));
    return this;
  }
}

class _$AppModule extends _i850.AppModule {}
