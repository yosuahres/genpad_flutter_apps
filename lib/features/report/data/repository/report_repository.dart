// lib/features/report/data/repository/report_repository.dart
import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:injectable/injectable.dart';

@injectable
class ReportRepository {
  final SupabaseClient _client;
  ReportRepository(this._client);

  Future<List<String>> uploadMultipleFiles(List<File> files, String baseFileName) async {
    List<String> urls = [];
    for (int i = 0; i < files.length; i++) {
      final path = 'reports/${baseFileName}_${DateTime.now().millisecondsSinceEpoch}_$i.jpg';
      await _client.storage.from('reports').upload(path, files[i]);
      urls.add(_client.storage.from('reports').getPublicUrl(path));
    }
    return urls;
  }

  Future<void> saveReportMetadata({
    required String fileName,
    required List<String> imageUrls,
    required String childName,
    required String region,
    required String level,
    required String year,
  }) async {
    try {
      await _client.from('reports').insert({
        'file_name': fileName,
        'image_urls': imageUrls, // Store as List/JSONB in Supabase
        'child_name': childName,
        'region': region,
        'education_level': level,
        'academic_year': year,
        'uploaded_at': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      throw Exception('Database Error: $e');
    }
  }
}