import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import '../../../../dependency_injection.dart';
import '../../domain/use_cases/upload_report_use_case.dart';
import 'custom_camera_screen.dart';
import 'uploaded_reports_page.dart';

class UploaderPage extends StatefulWidget {
  const UploaderPage({super.key});

  @override
  State<UploaderPage> createState() => _UploaderPageState();
}

class _UploaderPageState extends State<UploaderPage> {
  bool _isUploading = false;
  double _uploadProgress = 0.0;

  void _startCaptureWorkflow() async {
    final cameras = await availableCameras();
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => CustomCameraScreen(cameras: cameras)),
    );

    if (result != null && result is Map<String, dynamic>) {
      _performFinalUpload(result['images'], result['fileName']);
    }
  }

  Future<void> _performFinalUpload(List<File> images, String fileName) async {
    setState(() {
      _isUploading = true;
      _uploadProgress = 0.0;
    });

    try {
      final uploadUseCase = getIt<UploadReportUseCase>();
      
      for (int i = 0; i < images.length; i++) {
        // Upload each image
        await uploadUseCase.execute(images[i], fileName);
        
        setState(() {
          _uploadProgress = (i + 1) / images.length;
        });
      }

      if (!mounted) return;
      
      // Success! Redirect to the reports list
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const UploadedReportsPage()),
        (route) => route.isFirst,
      );
      
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Upload failed: $e'), backgroundColor: Colors.red),
      );
    } finally {
      if (mounted) setState(() => _isUploading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New Report')),
      body: Center(
        child: _isUploading 
          ? _buildLoadingState()
          : _buildInitialState(),
      ),
    );
  }

  Widget _buildLoadingState() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CircularProgressIndicator(),
        const SizedBox(height: 20),
        Text('Uploading... ${( _uploadProgress * 100).toInt()}%'),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
          child: LinearProgressIndicator(value: _uploadProgress),
        ),
      ],
    );
  }

  Widget _buildInitialState() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.upload_file, size: 80, color: Colors.blue.shade200),
        const SizedBox(height: 16),
        const Text('Ready to scan your documents?'),
        const SizedBox(height: 24),
        ElevatedButton(
          onPressed: _startCaptureWorkflow,
          style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16)),
          child: const Text('START SCANNING'),
        ),
      ],
    );
  }
}