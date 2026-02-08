// lib/features/report/domain/entities/document_entity.dart

class DocumentEntity {
  final String? id;
  final String childId;
  final String documentType;
  final String filePath;
  final String fileType;
  final int fileSize;
  final String uploadStatus;
  final String? checksum;
  final String uploadedBy;
  final DateTime createdAt;
  final DateTime? syncedAt;

  DocumentEntity({
    this.id,
    required this.childId,
    required this.documentType,
    required this.filePath,
    required this.fileType,
    required this.fileSize,
    required this.uploadStatus,
    this.checksum,
    required this.uploadedBy,
    required this.createdAt,
    this.syncedAt,
  });

  Map<String, dynamic> toJson() => {
    'child_id': childId,
    'document_type': documentType,
    'file_path': filePath,
    'file_type': fileType,
    'file_size': fileSize,
    'upload_status': uploadStatus,
    'checksum': checksum,
    'uploaded_by': uploadedBy,
    'created_at': createdAt.toIso8601String(),
    'synced_at': syncedAt?.toIso8601String(),
  };

  factory DocumentEntity.fromJson(Map<String, dynamic> json) {
    return DocumentEntity(
      id: json['id']?.toString(),
      childId: json['child_id'] ?? '',
      documentType: json['document_type'] ?? '',
      filePath: json['file_path'] ?? '',
      fileType: json['file_type'] ?? '',
      fileSize: json['file_size'] ?? 0,
      uploadStatus: json['upload_status'] ?? '',
      checksum: json['checksum'],
      uploadedBy: json['uploaded_by'] ?? '',
      createdAt: DateTime.parse(json['created_at']),
      syncedAt: json['synced_at'] != null ? DateTime.parse(json['synced_at']) : null,
    );
  }
}