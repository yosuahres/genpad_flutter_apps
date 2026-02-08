// lib/features/report/presentation/pages/uploaded_reports_page.dart
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../domain/entities/report.dart';

class UploadedReportsPage extends StatelessWidget {
  const UploadedReportsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Document History')),
      body: StreamBuilder(
        stream: Supabase.instance.client.from('documents').stream(primaryKey: ['id']),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          
          final docs = (snapshot.data as List).map((e) => DocumentEntity.fromJson(e)).toList();

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final doc = docs[index];
              return ListTile(
                leading: const Icon(Icons.file_present),
                title: Text(doc.filePath.split('/').last),
                subtitle: Text('Child: ${doc.childId} | Type: ${doc.documentType}'),
                trailing: Text('${(doc.fileSize / 1024).toStringAsFixed(1)} KB'),
              );
            },
          );
        },
      ),
    );
  }
}