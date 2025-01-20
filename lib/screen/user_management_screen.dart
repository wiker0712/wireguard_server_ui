import 'package:flutter/material.dart';
import '../utils/global.dart';
import '/function/user_add.dart';
import '/function/user_sub.dart';

class UserManagementScreen extends StatelessWidget {
  const UserManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('사용자 관리'),
      ),
      body: const Center(
        child: Text(
          '여기에 사용자 관리 UI를 구현하세요.',
          style: TextStyle(fontSize: 18),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              // UserAdd 호출
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  final TextEditingController nameController = TextEditingController();
                  return AlertDialog(
                    title: const Text('사용자 추가'),
                    content: TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        labelText: '사용자 이름',
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Dialog 닫기
                        },
                        child: const Text('취소'),
                      ),
                      TextButton(
                        onPressed: () {
                          final userName = nameController.text;
                          //print('사용자 이름: $userName'); // 나중에 콘솔 명령어와 연동 예정
                          Navigator.of(context).pop(); // Dialog 닫기
                          // UserAdd 호출
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => UserAdd(userName: userName, serverIp: getServerIp(), clientIp: '10.13.13.2')),
                          );
                        },
                        child: const Text('추가'),
                      ),
                    ],
                  );
                },
              );
            },
            tooltip: '사용자 추가',
            child: const Icon(Icons.add),
          ),
          const SizedBox(width: 16), // 아이콘 간 간격
          FloatingActionButton(
            onPressed: () {
              // UserSub 호출
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const UserSub()),
              );
            },
            tooltip: '사용자 제거',
            child: const Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}
