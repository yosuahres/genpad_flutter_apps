import 'dart:io';
import '../entities/report.dart';
import '../../data/repository/report_repository.dart';
import 'package:injectable/injectable.dart';


@injectable
class UploadReportUseCase {
  final ReportRepository _repository;

  UploadReportUseCase(this._repository);

  Future<Report> execute(File file, String fileName) async {
    final imageUrl = await _repository.uploadFile(file, fileName);
    await _repository.saveReportMetadata(fileName, imageUrl);

    return Report(
      fileName: fileName,
      imageUrl: imageUrl,
      uploadedAt: DateTime.now(),
    );
  }
}