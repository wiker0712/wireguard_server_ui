import 'package:flutter/material.dart';
import '../utils/global.dart';
import '/function/user_add.dart';
import '/function/user_sub.dart';

class UserManagementScreen extends StatefulWidget {
  const UserManagementScreen({super.key});

  @override
  State<UserManagementScreen> createState() => _UserManagementScreenState();
}

class _UserManagementScreenState extends State<UserManagementScreen> {
  List<String> users = [];

  void _addUser(String userName) {
    // 호출: user_add.dart의 userAdd 함수
    print('실험' + GlobalState().containerName);
    userAdd(context, userName, GlobalState().getServerIp(), '10.13.13.2');

    // UI 업데이트: 리스트에 사용자 추가
    setState(() {
      users.add(userName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('사용자 관리'),
      ),
      body: users.isEmpty
          ? const Center(
        child: Text(
          '추가된 사용자가 없습니다.',
          style: TextStyle(fontSize: 18),
        ),
      )
          : ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              title: Text(user),
              // 추가적인 사용자 정보나 액션을 여기에 넣을 수 있음
            ),
          );
        },
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              // 사용자 추가 다이얼로그
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
                          Navigator.of(context).pop(); // 다이얼로그 닫기
                        },
                        child: const Text('취소'),
                      ),
                      TextButton(
                        onPressed: () {
                          final userName = nameController.text;
                          Navigator.of(context).pop(); // 다이얼로그 닫기
                          _addUser(userName); // 사용자 추가 함수 호출
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
          const SizedBox(width: 16),
          FloatingActionButton(
            onPressed: () {
              // 사용자 제거 화면으로 이동
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
