import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:camera/camera.dart';
import 'package:application_genpad_local/dependency_injection.dart';
import 'package:application_genpad_local/features/home/presentation/bloc/bottom_navigation_bar/bottom_navigation_bar_cubit.dart';
import 'package:application_genpad_local/features/home/presentation/widgets/home_navigation_bar.dart';
import 'package:application_genpad_local/features/report/presentation/pages/custom_camera_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _showActionSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Camera'),
              onTap: () async {
                Navigator.pop(context);
                final cameras = await availableCameras();
                if (context.mounted) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CustomCameraScreen(cameras: cameras),
                    ),
                  );
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Image Gallery'),
              onTap: () {
                Navigator.pop(context);
                // Trigger your ImagePicker logic here
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<BottomNavigationBarCubit>(),
      child: BlocBuilder<BottomNavigationBarCubit, BottomNavigationBarState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(title: Text(state.tabs[state.selectedIndex].label)),
            body: state.tabs[state.selectedIndex].content,
            
            // THE PLUS CIRCLE IN THE MIDDLE
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            floatingActionButton: FloatingActionButton(
              shape: const CircleBorder(),
              backgroundColor: Colors.blue[700],
              onPressed: () => _showActionSheet(context),
              child: const Icon(Icons.add, color: Colors.white, size: 30),
            ),
            
            bottomNavigationBar: HomeNavigationBar(
              selectedIndex: state.selectedIndex,
              tabs: state.tabs,
            ),
          );
        },
      ),
    );
  }
}