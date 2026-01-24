import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:application_genpad_local/dependency_injection.dart';

//pages
import 'package:application_genpad_local/features/home/presentation/widgets/welcome_content.dart';
import 'package:application_genpad_local/features/settings/presentation/page/settings_page.dart';
import 'package:application_genpad_local/features/report/presentation/uploader_page.dart'; 
import 'package:application_genpad_local/features/report/domain/use_cases/upload_report_use_case.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'bottom_navigation_bar_state.dart';

@injectable
class BottomNavigationBarCubit extends Cubit<BottomNavigationBarState> {
  BottomNavigationBarCubit()
      : super(
          BottomNavigationBarState(),
        );

  void switchTab(int index) {
    emit(state.copyWith(
      selectedIndex: index,
    ));
  }
}
