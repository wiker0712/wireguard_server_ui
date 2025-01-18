import 'dart:io';
import 'package:flutter/material.dart';
import '../function/server_add.dart';
import '../screen/user_management_screen.dart';

class ServerCreationScreen extends StatefulWidget {
  const ServerCreationScreen({super.key});

  @override
  _ServerCreationScreenState createState() => _ServerCreationScreenState();
}

class _ServerCreationScreenState extends State<ServerCreationScreen> {
  final String basePath = '${Platform.environment['APPDATA']}\\wireguardserverui';

  List<Map<String, String>> servers = [];
  int? expandedIndex; // 확장된 카드의 인덱스

  @override
  void initState() {
    super.initState();
    _loadServers();
  }

  Future<void> _loadServers() async {
    final directory = Directory(basePath);

    if (await directory.exists()) {
      final subdirectories = directory.listSync().whereType<Directory>();
      List<Map<String, String>> tempServers = [];

      for (var subdir in subdirectories) {
        final file = File('${subdir.path}\\cardinfo.txt');
        if (await file.exists()) {
          final lines = await file.readAsLines();
          if (lines.length >= 2) {
            tempServers.add({
              'name': lines[0].trim(),
              'ip': lines[1].trim(),
            });
          }
        }
      }

      setState(() {
        servers = tempServers;
      });
    }
  }

  Future<void> _addServer() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ServerAdd()),
    );

    if (result == true) {
      // 새 서버를 추가한 경우 목록 갱신
      _loadServers();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('서버 생성'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _addServer, // 서버 추가 화면 호출
          ),
        ],
      ),
      body: servers.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: servers.length,
        itemBuilder: (context, index) {
          final server = servers[index];
          final isExpanded = expandedIndex == index;

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  expandedIndex = isExpanded ? null : index;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(16.0),
                height: isExpanded ? 200 : 100, // 클릭 시 높이 변경
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            server['name']!,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'IP: ${server['ip']}',
                            style: const TextStyle(fontSize: 16),
                          ),
                          if (isExpanded) ...[
                            const SizedBox(height: 16),
                            const Text(
                              '추가적인 상세 정보가 여기에 표시됩니다.',
                              style: TextStyle(fontSize: 14),
                            ),
                          ],
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.person_add),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const UserManagementScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}


