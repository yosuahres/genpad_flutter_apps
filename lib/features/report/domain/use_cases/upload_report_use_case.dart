
import 'dart:io';
import 'package:injectable/injectable.dart';
import '../entities/report.dart';
import '../../data/repository/report_repository.dart';

@injectable
class UploadReportUseCase {
  final ReportRepository _repository;
  UploadReportUseCase(this._repository);

  Future<void> execute({
    required List<File> files,
    required String childId,
    required String documentType,
    required String uploadedBy,
  }) async {
    for (var file in files) {
      final fileName = "${DateTime.now().millisecondsSinceEpoch}_${file.path.split('/').last}";
      final remotePath = 'uploads/$childId/$fileName';

      
      await _repository.uploadFile(file, remotePath);

      
      final doc = DocumentEntity(
        childId: childId,
        documentType: documentType,
        filePath: remotePath,
        fileType: file.path.split('.').last,
        fileSize: await file.length(),
        uploadStatus: 'success',
        uploadedBy: uploadedBy,
        createdAt: DateTime.now(),
      );

      await _repository.saveDocumentEntry(doc);
    }
  }
}