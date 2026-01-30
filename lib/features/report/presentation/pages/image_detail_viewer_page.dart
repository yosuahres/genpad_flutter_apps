import 'dart:io';
import 'package:flutter/material.dart';
import 'review_grid_page.dart';

class ImageDetailViewerPage extends StatefulWidget {
  final List<File> images;
  final int initialIndex;
  final bool isNewSelection; // True if coming from Camera or Gallery Picker

  const ImageDetailViewerPage({
    super.key,
    required this.images,
    required this.initialIndex,
    this.isNewSelection = false,
  });

  @override
  State<ImageDetailViewerPage> createState() => _ImageDetailViewerPageState();
}

class _ImageDetailViewerPageState extends State<ImageDetailViewerPage> {
  late PageController _controller;
  late int _currentIndex;
  late List<File> _currentImages;

  @override
  void initState() {
    super.initState();
    _currentImages = List.from(widget.images);
    _currentIndex = widget.initialIndex;
    _controller = PageController(initialPage: widget.initialIndex);
  }

  void _deleteImage() {
    setState(() {
      _currentImages.removeAt(_currentIndex);
      if (_currentImages.isEmpty) {
        Navigator.pop(context);
      } else if (_currentIndex >= _currentImages.length) {
        _currentIndex = _currentImages.length - 1;
      }
    });
  }

  void _onNext() {
    if (widget.isNewSelection) {
      // Proceed to the final Grid & Filename page
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ReviewGridPage(
            images: _currentImages,
            initialFileName: "Upload_${DateTime.now().millisecondsSinceEpoch}",
          ),
        ),
      );
    } else {
      // Just returning from a preview click in the Grid
      Navigator.pop(context, _currentImages);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Text('${_currentIndex + 1} / ${_currentImages.length}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
            onPressed: _deleteImage,
          ),
        ],
      ),
      body: Stack(
        children: [
          PageView.builder(
            controller: _controller,
            onPageChanged: (i) => setState(() => _currentIndex = i),
            itemCount: _currentImages.length,
            itemBuilder: (context, index) => InteractiveViewer(
              child: Image.file(_currentImages[index], fit: BoxFit.contain),
            ),
          ),
          
          // Navigation Arrows
          if (_currentImages.length > 1) ...[
            _buildArrow(Alignment.centerLeft, Icons.chevron_left, 
                () => _controller.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.ease)),
            _buildArrow(Alignment.centerRight, Icons.chevron_right, 
                () => _controller.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.ease)),
          ],

          // Bottom Action Button
          Positioned(
            bottom: 40,
            left: 20,
            right: 20,
            child: FloatingActionButton.extended(
              backgroundColor: Colors.blueAccent,
              onPressed: _onNext,
              icon: Icon(widget.isNewSelection ? Icons.grid_view : Icons.check),
              label: Text(widget.isNewSelection ? 'Review in Grid' : 'Confirm'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildArrow(Alignment align, IconData icon, VoidCallback onTap) {
    return Align(
      alignment: align,
      child: IconButton(
        icon: Icon(icon, color: Colors.white54, size: 50),
        onPressed: onTap,
      ),
    );
  }
}