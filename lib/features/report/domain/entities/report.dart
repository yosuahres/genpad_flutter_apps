class Report {
  final String fileName;
  final String imageUrl;
  final DateTime uploadedAt;

  Report({
    required this.fileName,
    required this.imageUrl,
    required this.uploadedAt,
  });

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      fileName: json['file_name'],
      imageUrl: json['image_url'],
      uploadedAt: DateTime.parse(json['uploaded_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'file_name': fileName,
      'image_url': imageUrl,
      'uploaded_at': uploadedAt.toIso8601String(),
    };
  }
}