
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
  final _childIdController = TextEditingController();
  String _selectedDocType = 'Report Card'; 
  bool _isUploading = false;

  Future<void> _handleUpload() async {
    if (_childIdController.text.isEmpty) return;
    
    setState(() => _isUploading = true);
    try {
      await getIt<UploadReportUseCase>().execute(
        files: widget.images,
        childId: _childIdController.text,
        documentType: _selectedDocType,
        uploadedBy: "current_user_id", 
      );
      if (mounted) Navigator.of(context).popUntil((route) => route.isFirst);
    } catch (e) {
      setState(() => _isUploading = false);
      
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Document Details')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _childIdController,
              decoration: const InputDecoration(labelText: 'Child ID', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _selectedDocType,
              items: ['Report Card', 'Certificate', 'Other'].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              onChanged: (v) => setState(() => _selectedDocType = v!),
              decoration: const InputDecoration(labelText: 'Document Type', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 20),
            
            ElevatedButton(
              onPressed: _isUploading ? null : _handleUpload,
              child: _isUploading ? const CircularProgressIndicator() : const Text('UPLOAD ALL'),
            )
          ],
        ),
      ),
    );
  }
} 