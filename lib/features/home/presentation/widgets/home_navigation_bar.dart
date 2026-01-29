import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/bottom_navigation_bar/bottom_navigation_bar_cubit.dart';

class HomeNavigationBar extends StatelessWidget {
  const HomeNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.tabs,
  });

  final int selectedIndex;
  final List<TabItem> tabs;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 8.0,
      clipBehavior: Clip.antiAlias,
      child: SizedBox(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // Left side items
            _buildTabItem(context, 0),
            
            // Spacer for the Floating Action Button
            const SizedBox(width: 40),
            
            // Right side items
            _buildTabItem(context, 1),
          ],
        ),
      ),
    );
  }

  Widget _buildTabItem(BuildContext context, int index) {
    final isSelected = selectedIndex == index;
    return InkWell(
      onTap: () => context.read<BottomNavigationBarCubit>().switchTab(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            tabs[index].icon,
            color: isSelected ? Colors.blue[700] : Colors.grey,
          ),
          Text(
            tabs[index].label,
            style: TextStyle(
              color: isSelected ? Colors.blue[700] : Colors.grey,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}