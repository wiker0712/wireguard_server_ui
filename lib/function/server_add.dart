import 'dart:io';
import 'package:flutter/material.dart';

class ServerAdd extends StatelessWidget {
  const ServerAdd({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final ipController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('서버 추가'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: '서버 이름'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: ipController,
              decoration: const InputDecoration(labelText: 'IP 주소'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final directory = Directory('${Platform.environment['APPDATA']}\\wireguardserverui\\${nameController.text}');
                if (!await directory.exists()) {
                  await directory.create(recursive: true);
                  final file = File('${directory.path}\\cardinfo.txt');
                  await file.writeAsString('${nameController.text}\n${ipController.text}\n');
                  Navigator.pop(context, true); // 새 서버 추가 완료 후 반환
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('이미 존재하는 서버입니다.')),
                  );
                }
              },
              child: const Text('서버 추가'),
            ),
          ],
        ),
      ),
    );
  }
}

