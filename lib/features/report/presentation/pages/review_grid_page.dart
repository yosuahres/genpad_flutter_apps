import 'dart:io';
import 'package:flutter/material.dart';
import 'image_detail_viewer_page.dart';

class ReviewGridPage extends StatefulWidget {
  final List<File> images;
  final String initialFileName;

  const ReviewGridPage({super.key, required this.images, required this.initialFileName});

  @override
  State<ReviewGridPage> createState() => _ReviewGridPageState();
}

class _ReviewGridPageState extends State<ReviewGridPage> {
  late TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialFileName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Review Grid')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Filename', suffixIcon: Icon(Icons.edit)),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 8, mainAxisSpacing: 8),
              itemCount: widget.images.length,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ImageDetailViewerPage(images: widget.images, initialIndex: index))),
                child: ClipRRect(borderRadius: BorderRadius.circular(8), child: Image.file(widget.images[index], fit: BoxFit.cover)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 50)),
              onPressed: () => Navigator.pop(context, {'images': widget.images, 'fileName': _nameController.text}),
              child: const Text('START UPLOAD'),
            ),
          ),
        ],
      ),
    );
  }
}