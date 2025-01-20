import 'package:flutter/material.dart';

class UserSub extends StatelessWidget {
  const UserSub({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('사용자 제거'),
      ),
      body: const Center(
        child: Text(
          '사용자 제거 화면입니다.',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
