import 'dart:io';
import 'package:flutter/material.dart';
import 'package:application_genpad_local/dependency_injection.dart';
import 'package:application_genpad_local/features/report/domain/use_cases/upload_report_use_case.dart';
import 'image_detail_viewer_page.dart';

class ReviewGridPage extends StatefulWidget {
  final List<File> images;
  final String initialFileName;

  const ReviewGridPage({
    super.key,
    required this.images,
    required this.initialFileName,
  });

  @override
  State<ReviewGridPage> createState() => _ReviewGridPageState();
}

class _ReviewGridPageState extends State<ReviewGridPage> {
  // Form Controllers
  late TextEditingController _fileNameController;
  late TextEditingController _childNameController;
  late TextEditingController _regionController;
  late TextEditingController _academicYearController;

  // Dropdown State
  String? _selectedLevel;
  final List<String> _educationLevels = ['TK', 'SD', 'SMP', 'SMA'];

  // Upload State
  bool _isUploading = false;

  @override
  void initState() {
    super.initState();
    _fileNameController = TextEditingController(text: widget.initialFileName);
    _childNameController = TextEditingController();
    _regionController = TextEditingController();
    _academicYearController = TextEditingController();
  }

  @override
  void dispose() {
    _fileNameController.dispose();
    _childNameController.dispose();
    _regionController.dispose();
    _academicYearController.dispose();
    super.dispose();
  }

  /// Triggers the sequential upload to Supabase Storage and Database
  Future<void> _handleUpload() async {
    // Basic Validation
    if (_selectedLevel == null || _childNameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in Child Name and Education Level')),
      );
      return;
    }

    setState(() => _isUploading = true);

    try {
      final uploadUseCase = getIt<UploadReportUseCase>();

      // Note: We are assuming you updated the UseCase to accept these new parameters
      await uploadUseCase.execute(
        images: widget.images,
        fileName: _fileNameController.text,
        childName: _childNameController.text,
        region: _regionController.text,
        level: _selectedLevel!,
        year: _academicYearController.text,
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(backgroundColor: Colors.green, content: Text('Upload Successful!')),
        );
        // Returns to the first screen (Home/List)
        Navigator.of(context).popUntil((route) => route.isFirst);
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isUploading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(backgroundColor: Colors.red, content: Text('Upload Failed: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Report Details'),
        // Disable back button during upload to prevent data corruption
        automaticallyImplyLeading: !_isUploading,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTextField(_fileNameController, 'Filename', Icons.file_copy),
                      const SizedBox(height: 12),
                      _buildTextField(_childNameController, 'Nama Anak', Icons.person),
                      const SizedBox(height: 12),
                      _buildTextField(_regionController, 'Daerah/Kota', Icons.map),
                      const SizedBox(height: 12),
                      
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: DropdownButtonFormField<String>(
                              value: _selectedLevel,
                              decoration: const InputDecoration(
                                labelText: 'Jenjang',
                                border: OutlineInputBorder(),
                              ),
                              items: _educationLevels.map((level) {
                                return DropdownMenuItem(value: level, child: Text(level));
                              }).toList(),
                              onChanged: _isUploading ? null : (val) => setState(() => _selectedLevel = val),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            flex: 3,
                            child: _buildTextField(_academicYearController, 'Tahun Ajaran', Icons.history_edu, hint: '2025/2026'),
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),
                      Text(
                        'Images (${widget.images.length})',
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(height: 8),

                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                        ),
                        itemCount: widget.images.length,
                        itemBuilder: (context, index) => GestureDetector(
                          onTap: _isUploading ? null : () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ImageDetailViewerPage(
                                images: widget.images,
                                initialIndex: index,
                              ),
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.file(widget.images[index], fit: BoxFit.cover),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              Padding(
                padding: const EdgeInsets.all(20),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    backgroundColor: Colors.blueAccent,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: Colors.grey,
                  ),
                  onPressed: _isUploading ? null : _handleUpload,
                  child: _isUploading 
                      ? const SizedBox(
                          height: 20, 
                          width: 20, 
                          child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                        )
                      : const Text('START UPLOAD', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
          
          // Loading Overlay to prevent any interaction during upload
          if (_isUploading)
            Container(
              color: Colors.black12,
              child: const Center(child: null), 
            ),
        ],
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon, {String? hint}) {
    return TextField(
      controller: controller,
      enabled: !_isUploading,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon),
        border: const OutlineInputBorder(),
      ),
    );
  }
}