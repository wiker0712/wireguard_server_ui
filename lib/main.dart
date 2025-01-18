import 'package:flutter/material.dart';
import 'screen/server_creation_screen.dart';
import 'screen/user_management_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VPN 관리 앱',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ServerCreationScreen(),
    );
  }
}



