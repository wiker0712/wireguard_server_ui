import 'package:flutter/material.dart';
import 'dart:io';
import '../utils//global.dart';


Future<void> userAdd(BuildContext context, String userName, String serverIp, String clientIp) async {
  // 컨테이너 이름 (예시)
  String _containerName = "test";
  String _serverIp = "60.253.3.222";
  // 1. useradd.sh 파일을 컨테이너에 복사
  ProcessResult cpResult = await Process.run(
    'docker',
    ['cp', 'useradd.sh', '$_containerName:/useradd.sh'],
  );
  print(_containerName);
  print('cp stdout: ${cpResult.stdout}');
  print('cp stderr: ${cpResult.stderr}');

  // 2. dos2unix 설치
  //    (이미 Alpine 기반 컨테이너여야 하고, 패키지 관리자 apk 사용 가능해야 함)
  ProcessResult installDos2Unix = await Process.run(
    'docker',
    ['exec', _containerName, 'apk', 'add', '--no-cache', 'dos2unix'],
  );
  print('dos2unix install stdout: ${installDos2Unix.stdout}');
  print('dos2unix install stderr: ${installDos2Unix.stderr}');

  // 3. dos2unix로 CRLF → LF 변환
  ProcessResult runDos2Unix = await Process.run(
    'docker',
    ['exec', _containerName, 'dos2unix', '/useradd.sh'],
  );
  print('dos2unix stdout: ${runDos2Unix.stdout}');
  print('dos2unix stderr: ${runDos2Unix.stderr}');

  // 4. 컨테이너 내에서 실행 권한 부여
  ProcessResult chmodResult = await Process.run(
    'docker',
    ['exec', _containerName, 'chmod', '+x', '/useradd.sh'],
  );
  print('chmod stdout: ${chmodResult.stdout}');
  print('chmod stderr: ${chmodResult.stderr}');

  // 5. 스크립트 실행 시 필요한 인자 전달: userName, serverIp, clientIp
  print('user: $userName, server: $_serverIp, client: $clientIp');
  ProcessResult result = await Process.run(
    'docker',
    ['exec', _containerName, 'bash', '-c', '/useradd.sh $userName $_serverIp $clientIp'],
  );

  // 6. 실행 결과 확인
  if (result.exitCode == 0) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('User $userName added successfully!')),
    );
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error adding user: ${result.stderr}')),
    );
  }
}
// Future<void> userAdd(BuildContext context, String userName, String serverIp, String clientIp) async {
//   // 컨테이너 안에 sh 파일 넣고 다시 이미지로 만들어서 이용
//
//   // 1. useradd.sh 파일을 컨테이너에 복사
//   String _containerName = "test";
//   ProcessResult cpResult = await Process.run('docker', ['cp', 'useradd.sh', '$_containerName:/useradd.sh']);
//   print(_containerName);
//   print('h1'+cpResult.stdout);
//   print('h2'+cpResult.stderr);
//
//   // 2. 컨테이너 내에서 실행 권한 부여
//   await Process.run('docker', ['exec', _containerName, 'chmod', '+x', '/useradd.sh']);
//
//   // 3. 스크립트 실행 시 필요한 인자 전달: userName, serverIp, clientIp
//   print('user '+userName + 'server '+serverIp + 'client '+clientIp);
//   ProcessResult result = await Process.run(
//     'docker',
//     ['exec', _containerName, 'bash', '-c', '/useradd.sh $userName $serverIp $clientIp'],
//   );
//
//   if (result.exitCode == 0) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('User $userName added successfully!')),
//     );
//   } else {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('Error adding user: ${result.stderr}')),
//     );
//   }
// }



//클라이언트 파일
//address 10.13.13.2 부터 시작 10.13.13.1은 서버

//서버 파일
//address 10.13.13.1

//peer
// allowedIPs peer의 address 10.3.13.2/32
