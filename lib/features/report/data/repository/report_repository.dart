import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:storage_client/storage_client.dart';

class ReportRepository {
  final SupabaseClient _client;

  ReportRepository(this._client);

  Future<String> uploadFile(File file, String fileName) async {
    const bucketName = 'reports';
    final filePath = '${fileName}_${DateTime.now().millisecondsSinceEpoch}.jpg';

    try {
      final bucketExists = await _client.storage.from(bucketName).list();
      if (bucketExists.isEmpty) {
        await _client.storage.createBucket(bucketName);
        await _client.storage.updateBucket(
          bucketName,
          BucketOptions(public: true),
        );
      }

      await _client.storage.from(bucketName).upload(filePath, file);
      return _client.storage.from(bucketName).getPublicUrl(filePath);
    } catch (e) {
      throw Exception('File upload failed: $e');
    }
  }

  Future<void> saveReportMetadata(String fileName, String imageUrl) async {
    try {
      await _client.from('reports').insert({
        'file_name': fileName,
        'image_url': imageUrl,
        'uploaded_at': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      throw Exception('Saving metadata failed: $e');
    }
  }
}