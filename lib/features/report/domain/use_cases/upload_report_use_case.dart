import 'dart:io';
import 'package:injectable/injectable.dart';
import '../../data/repository/report_repository.dart';

@injectable
class UploadReportUseCase {
  final ReportRepository _repository;
  UploadReportUseCase(this._repository);

  Future<void> execute(File file, String fileName) async {
    // 1. Upload to Storage
    final String publicUrl = await _repository.uploadFile(file, fileName);
    
    // 2. Save Reference to Database
    await _repository.saveReportMetadata(fileName, publicUrl);
  }
}