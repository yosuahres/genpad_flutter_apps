import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:camera/camera.dart';
import '../../../../dependency_injection.dart';
import 'package:application_genpad_local/features/home/presentation/bloc/bottom_navigation_bar/bottom_navigation_bar_cubit.dart';
import 'package:application_genpad_local/features/report/presentation/pages/custom_camera_screen.dart';
// import 'package:application_genpad_local/features/report/presentation/pages/gallery_selection_page.dart';
import 'package:application_genpad_local/features/report/presentation/pages/image_detail_viewer_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _showPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Camera'),
              onTap: () async {
                Navigator.pop(ctx);
                final cams = await availableCameras();
                if (context.mounted) Navigator.push(context, MaterialPageRoute(builder: (_) => CustomCameraScreen(cameras: cams)));
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Gallery'),
              onTap: () async {
                Navigator.pop(ctx);
                final ImagePicker picker = ImagePicker();
                
                // 1. User picks images from the system gallery
                final List<XFile> pickedFiles = await picker.pickMultiImage();
                
                if (pickedFiles.isNotEmpty && context.mounted) {
                  final files = pickedFiles.map((e) => File(e.path)).toList();
                  
                  // 2. Direct jump to Full-Screen Detail Viewer
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ImageDetailViewerPage(
                        images: files,
                        initialIndex: 0,
                        isNewSelection: true, // Use a single flag for both Camera & Gallery
                      ),
                    ),
                  );
                }
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
            body: IndexedStack(index: state.selectedIndex, children: state.tabs.map((e) => e.content).toList()),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            floatingActionButton: FloatingActionButton(
              shape: const CircleBorder(),
              backgroundColor: Colors.blue[700],
              onPressed: () => _showPicker(context),
              child: const Icon(Icons.add, color: Colors.white),
            ),
            bottomNavigationBar: BottomAppBar(
              shape: const CircularNotchedRectangle(),
              notchMargin: 8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    icon: Icon(Icons.list, color: state.selectedIndex == 0 ? Colors.blue : Colors.grey),
                    onPressed: () => context.read<BottomNavigationBarCubit>().switchTab(0),
                  ),
                  const SizedBox(width: 40),
                  IconButton(
                    icon: Icon(Icons.settings, color: state.selectedIndex == 1 ? Colors.blue : Colors.grey),
                    onPressed: () => context.read<BottomNavigationBarCubit>().switchTab(1),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}