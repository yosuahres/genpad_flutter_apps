import 'package:flutter/material.dart';

class UploadedReportsPage extends StatelessWidget {
  const UploadedReportsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Uploaded Reports'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Search by File Name',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
              },
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: 10, 
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('Report File #$index'),
                    subtitle: Text('Uploaded on: 2026-01-20'),
                    onTap: () {
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}