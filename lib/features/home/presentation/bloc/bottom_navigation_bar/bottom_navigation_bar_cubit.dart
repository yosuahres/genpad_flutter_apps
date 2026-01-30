import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import '../../../../report/presentation/pages/uploaded_reports_page.dart';
import '../../../../settings/presentation/page/settings_page.dart';

part 'bottom_navigation_bar_state.dart';

@injectable
class BottomNavigationBarCubit extends Cubit<BottomNavigationBarState> {
  BottomNavigationBarCubit() : super(BottomNavigationBarState());

  void switchTab(int index) => emit(state.copyWith(selectedIndex: index));
}