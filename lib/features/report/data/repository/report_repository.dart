import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:injectable/injectable.dart';

@injectable
class ReportRepository {
  final SupabaseClient _client;
  ReportRepository(this._client);

  Future<String> uploadFile(File file, String fileName) async {
    // Unique path: folder/filename_timestamp.jpg
    final path = 'reports/${fileName}_${DateTime.now().microsecondsSinceEpoch}.jpg';

    try {
      await _client.storage.from('reports').upload(path, file);
      return _client.storage.from('reports').getPublicUrl(path);
    } catch (e) {
      throw Exception('Supabase Storage Error: $e');
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
      throw Exception('Database Insertion Error: $e');
    }
  }
}