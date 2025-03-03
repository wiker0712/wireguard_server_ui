import 'dart:io';
import 'package:flutter/material.dart';
import '../function/docker_compose_generator.dart';
import '../utils//global.dart';

class ServerAdd extends StatelessWidget {
  const ServerAdd({super.key});

  @override
  Widget build(BuildContext context) {
    final containerNameController = TextEditingController();
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
              controller: containerNameController,
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
                final directory = GlobalState().getDirectory(containerNameController.text);

                // directory를 전역 변수에 저장
                GlobalState().currentDirectory = directory;
                //컨테이너 이름
                GlobalState().containerName = containerNameController.text;
                print('테스트: ' + GlobalState().containerName);
                // 서버 ip 저장
                GlobalState().serverIP = ipController.text;

                if (!await directory.exists()) {
                  await directory.create(recursive: true);

                  //config 폴더
                  final configDirectory = Directory('${directory.path}\\config');
                  if (!await configDirectory.exists()) {
                    await configDirectory.create();
                  }

                  //modules 폴더
                  final modulesDirectory = Directory('${directory.path}\\modules');
                  if (!await modulesDirectory.exists()) {
                    await modulesDirectory.create();
                  }

                  //docker-compose.yml 생성
                  final generator = DockerComposeGenerator(
                    containerName: containerNameController.text,
                    serverUrl: ipController.text,
                    appDataDirectory: directory.path,
                  );
                  await generator.generateComposeFile();

                  //정보 표시용
                  final file = File('${directory.path}\\cardinfo.txt');
                  await file.writeAsString('${containerNameController.text}\n${ipController.text}\n');

                  // docker-compose up -d 실행
                  try {
                    final result = await Process.run(
                      'docker-compose',
                      ['up', '-d'],
                      workingDirectory: directory.path,
                      runInShell: true, // Shell에서 실행 필요
                    );

                    if (result.exitCode == 0) {
                      // 성공적으로 실행된 경우
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Docker Compose 실행 완료.')),
                      );
                    } else {
                      // 실행 중 오류 발생
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('오류 발생: ${result.stderr}')),
                      );
                      print(result.stderr);
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('명령 실행 실패: $e')),
                    );
                    print('명령 실행 실패: $e');
                  }

                  //
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

