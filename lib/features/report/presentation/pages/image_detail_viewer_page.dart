import 'dart:io';
import 'package:flutter/material.dart';

class ImageDetailViewerPage extends StatefulWidget {
  final List<File> images;
  final int initialIndex;

  const ImageDetailViewerPage({super.key, required this.images, required this.initialIndex});

  @override
  State<ImageDetailViewerPage> createState() => _ImageDetailViewerPageState();
}

class _ImageDetailViewerPageState extends State<ImageDetailViewerPage> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(backgroundColor: Colors.transparent, foregroundColor: Colors.white),
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: widget.images.length,
            itemBuilder: (context, index) => Center(child: Image.file(widget.images[index])),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(icon: const Icon(Icons.chevron_left, color: Colors.white, size: 50), onPressed: () => _pageController.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.ease)),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(icon: const Icon(Icons.chevron_right, color: Colors.white, size: 50), onPressed: () => _pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.ease)),
          ),
          Positioned(
            bottom: 30, right: 20,
            child: FloatingActionButton(onPressed: () => Navigator.pop(context), child: const Icon(Icons.check)),
          )
        ],
      ),
    );
  }
}