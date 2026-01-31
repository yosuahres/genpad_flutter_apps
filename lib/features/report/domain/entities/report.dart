// lib/features/report/domain/entities/report.dart
class Report {
  final String fileName;
  final String imageUrl;
  final DateTime uploadedAt;

  Report({
    required this.fileName,
    required this.imageUrl,
    required this.uploadedAt,
  });

  factory Report.fromJson(Map<String, dynamic> json) => Report(
        fileName: json['file_name'],
        imageUrl: json['image_url'],
        uploadedAt: DateTime.parse(json['uploaded_at']),
      );

  Map<String, dynamic> toJson() => {
        'file_name': fileName,
        'image_url': imageUrl,
        'uploaded_at': uploadedAt.toIso8601String(),
      };
}