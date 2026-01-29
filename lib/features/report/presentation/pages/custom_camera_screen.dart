import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'review_grid_page.dart';

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
    _controller.initialize().then((_) => setState(() {}));
  }

  void _takePicture() async {
    final img = await _controller.takePicture();
    setState(() => _capturedImages.add(File(img.path)));
  }

  void _goToGridReview() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ReviewGridPage(
          images: _capturedImages,
          initialFileName: "Scan_${DateTime.now().millisecondsSinceEpoch}",
        ),
      ),
    );
    if (result != null) Navigator.pop(context, result);
  }

  @override
  Widget build(BuildContext context) {
    if (!_controller.value.isInitialized) return const Scaffold();
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          CameraPreview(_controller),
          Positioned(
            bottom: 40, left: 0, right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(width: 70),
                GestureDetector(
                  onTap: _takePicture,
                  child: const CircleAvatar(radius: 35, backgroundColor: Colors.white),
                ),
                _buildSmallPreview(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSmallPreview() {
    if (_capturedImages.isEmpty) return const SizedBox(width: 70);
    return GestureDetector(
      onTap: _goToGridReview,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 60, height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(image: FileImage(_capturedImages.last), fit: BoxFit.cover),
            ),
          ),
          Positioned(
            top: -5, right: -5,
            child: CircleAvatar(radius: 12, backgroundColor: Colors.red, child: Text('${_capturedImages.length}', style: const TextStyle(fontSize: 12))),
          ),
          const Positioned(bottom: -20, left: 10, child: Text('NEXT', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold))),
        ],
      ),
    );
  }
}