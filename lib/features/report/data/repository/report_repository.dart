// lib/features/report/data/repository/report_repository.dart
import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:injectable/injectable.dart';
import '../../domain/entities/report.dart';

@injectable
class ReportRepository {
  final SupabaseClient _client;
  ReportRepository(this._client);

  /// Uploads a file to Supabase Storage bucket 'documents'
  Future<String> uploadFile(File file, String remotePath) async {
    await _client.storage.from('documents').upload(remotePath, file);
    return remotePath;
  }

  /// Inserts a record into the 'documents' table
  Future<void> saveDocumentEntry(DocumentEntity document) async {
    try {
      await _client.from('documents').insert(document.toJson());
    } catch (e) {
      throw Exception('Database Error: $e');
    }
  }

  /// Fetches documents from the 'documents' table
  Future<List<DocumentEntity>> fetchDocuments() async {
    final response = await _client.from('documents').select().order('created_at');
    return (response as List).map((json) => DocumentEntity.fromJson(json)).toList();
  }
}