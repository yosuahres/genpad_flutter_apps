import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:camera/camera.dart';

import 'package:application_genpad_local/dependency_injection.dart';
import 'package:application_genpad_local/features/report/domain/use_cases/upload_report_use_case.dart'; 

class UploaderPage extends StatefulWidget {
  const UploaderPage({super.key});

  @override
  State<UploaderPage> createState() => _UploaderPageState();
}

class _UploaderPageState extends State<UploaderPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fileNameController = TextEditingController();
  List<File> _scannedImages = [];
  bool _isUploading = false;

  @override
  void dispose() {
    _fileNameController.dispose();
    super.dispose();
  }

  Future<void> _pickImages(ImageSource source) async {
    final picker = ImagePicker();

    if (source == ImageSource.gallery) {
      final pickedFiles = await picker.pickMultiImage();
      if (pickedFiles.isNotEmpty) {
        setState(() {
          _scannedImages.addAll(pickedFiles.map((file) => File(file.path)));
        });
      }
    } else if (source == ImageSource.camera) {
      await _navigateToCustomCamera();
    }
  }

  Future<void> _navigateToCustomCamera() async {
    final cameras = await availableCameras();
    final result = await Navigator.push<List<File>>(
      context,
      MaterialPageRoute(
        builder: (context) => CustomCameraScreen(cameras: cameras),
      ),
    );

    if (result != null && result.isNotEmpty) {
      setState(() {
        _scannedImages.addAll(result);
      });
    }
  }

  Future<void> _showImageSourceDialog() async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Take Picture'),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImages(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Choose from Gallery'),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImages(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _uploadData() async {
    if (_scannedImages.isEmpty || _fileNameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please complete all fields.')),
      );
      return;
    }

    setState(() {
      _isUploading = true;
    });

    try {

      final uploadReportUseCase = getIt<UploadReportUseCase>();
      
      for (var image in _scannedImages) {
        final report = await uploadReportUseCase.execute(
          image,
          _fileNameController.text,
        );

        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Uploaded: ${report.fileName}')),
        );  
      }

      setState(() {
        _scannedImages.clear();
        _fileNameController.clear();
      });
    } catch (e) {
      if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Upload failed: $e')),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isUploading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Uploader'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _fileNameController,
                decoration: const InputDecoration(
                  labelText: 'File Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a file name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _showImageSourceDialog,
                child: const Text('Add Documents'),
              ),
              if (_scannedImages.isNotEmpty) ...[
                const SizedBox(height: 16),
                SizedBox(
                  height: 200,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _scannedImages.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Column(
                          children: [
                            Image.file(
                              _scannedImages[index],
                              width: 150,
                              height: 150,
                              fit: BoxFit.cover,
                            ),
                            IconButton(
                              icon: const Icon(Icons.remove_circle, color: Colors.red),
                              onPressed: () {
                                setState(() {
                                  _scannedImages.removeAt(index);
                                });
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _isUploading ? null : _uploadData,
                child: _isUploading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Upload'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomCameraScreen extends StatefulWidget {
  final List<CameraDescription> cameras;

  const CustomCameraScreen({Key? key, required this.cameras}) : super(key: key);

  @override
  State<CustomCameraScreen> createState() => _CustomCameraScreenState();
}

class _CustomCameraScreenState extends State<CustomCameraScreen> {
  late CameraController _cameraController;
  List<File> _capturedImages = [];

  @override
  void initState() {
    super.initState();
    _cameraController = CameraController(
      widget.cameras.first,
      ResolutionPreset.high,
    );
    _cameraController.initialize().then((_) {
      if (!mounted) return;
      setState(() {});
    });
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  Future<void> _captureImage() async {
    try {
      final image = await _cameraController.takePicture();
      setState(() {
        _capturedImages.add(File(image.path));
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error capturing image: $e')),
      );
    }
  }

  void _finishCapturing() {
    Navigator.of(context).pop(_capturedImages);
  }

  @override
  Widget build(BuildContext context) {
    if (!_cameraController.value.isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Capture Documents'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: _finishCapturing,
          ),
        ],
      ),
      body: Column(
        children: [
          AspectRatio(
            aspectRatio: _cameraController.value.aspectRatio,
            child: CameraPreview(_cameraController),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _captureImage,
            child: const Text('Capture'),
          ),
          if (_capturedImages.isNotEmpty) ...[
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _capturedImages.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.file(
                      _capturedImages[index],
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
            ),
          ],
        ],
      ),
    );
  }
}