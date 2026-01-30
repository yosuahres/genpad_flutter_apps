import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'image_detail_viewer_page.dart'; // Import the detail viewer

class CustomCameraScreen extends StatefulWidget {
  final List<CameraDescription> cameras;
  const CustomCameraScreen({super.key, required this.cameras});

  @override
  State<CustomCameraScreen> createState() => _CustomCameraScreenState();
}

class _CustomCameraScreenState extends State<CustomCameraScreen> {
  late CameraController _controller;
  final List<File> _capturedImages = [];

  @override
  void initState() {
    super.initState();
    _controller = CameraController(widget.cameras.first, ResolutionPreset.high);
    _controller.initialize().then((_) {
      if (!mounted) return;
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _takePicture() async {
    try {
      final img = await _controller.takePicture();
      setState(() => _capturedImages.add(File(img.path)));
    } catch (e) {
      debugPrint("Error taking picture: $e");
    }
  }

  // UPDATED: Now goes to Detail Viewer first
  void _navigateToDetailViewer() async {
    if (_capturedImages.isEmpty) return;

    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ImageDetailViewerPage(
          images: _capturedImages,
          initialIndex: 0,
          // We use this flag so the viewer knows to push ReviewGrid next
          isNewSelection: true, 
        ),
      ),
    );

    // If the workflow finishes in the following pages and returns data
    if (result != null) {
      if (!mounted) return;
      Navigator.pop(context, result);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_controller.value.isInitialized) return const Scaffold(backgroundColor: Colors.black);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(child: CameraPreview(_controller)),
          Positioned(
            bottom: 40, left: 0, right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(width: 70),
                GestureDetector(
                  onTap: _takePicture,
                  child: _buildCaptureButton(),
                ),
                _buildSmallPreview(),
              ],
            ),
          ),
          Positioned(
            top: 50, left: 20,
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.white, size: 30),
              onPressed: () => Navigator.pop(context),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildCaptureButton() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 3),
      ),
      child: const CircleAvatar(radius: 30, backgroundColor: Colors.white),
    );
  }

  Widget _buildSmallPreview() {
    if (_capturedImages.isEmpty) return const SizedBox(width: 70);
    return GestureDetector(
      onTap: _navigateToDetailViewer, // Updated tap target
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 60, height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.white, width: 2),
              image: DecorationImage(
                image: FileImage(_capturedImages.last), 
                fit: BoxFit.cover
              ),
            ),
          ),
          Positioned(
            top: -8, right: -8,
            child: CircleAvatar(
              radius: 12, 
              backgroundColor: Colors.red, 
              child: Text('${_capturedImages.length}', style: const TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold))
            ),
          ),
          const Positioned(
            bottom: -25, left: 10, 
            child: Text('NEXT', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold))
          ),
        ],
      ),
    );
  }
}