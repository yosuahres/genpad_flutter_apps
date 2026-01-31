// lib/features/report/domain/use_cases/upload_report_use_case.dart
import 'dart:io';
import 'package:injectable/injectable.dart';
import '../../data/repository/report_repository.dart';

@injectable
class UploadReportUseCase {
  final ReportRepository _repository;
  UploadReportUseCase(this._repository);

  Future<void> execute({
    required List<File> images,
    required String fileName,
    required String childName,
    required String region,
    required String level,
    required String year,
  }) async {
    // 1. Upload all images to Storage
    final List<String> urls = await _repository.uploadMultipleFiles(images, fileName);
    
    // 2. Save metadata to DB
    await _repository.saveReportMetadata(
      fileName: fileName,
      imageUrls: urls,
      childName: childName,
      region: region,
      level: level,
      year: year,
    );
  }
}