import 'package:flutter/material.dart';

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
    );
  }
}