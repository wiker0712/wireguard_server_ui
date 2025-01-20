import 'dart:io';


class DockerComposeGenerator {
  final String containerName;
  final String serverUrl;
  final String appDataDirectory;

  DockerComposeGenerator({
    required this.containerName,
    required this.serverUrl,
    required this.appDataDirectory,
  });

  Future<void> generateComposeFile() async {
    // Compose 파일 내용 생성
    final composeContent = '''
version: '2.1'
services:
  ${containerName}:
    image: 'linuxserver/wireguard'
    container_name: ${containerName} #a1
    cap_add:
      - NET_ADMIN
      - SYS_MODULE
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Asia/Seoul
      - SERVERURL=${serverUrl} #a2
      - SERVERPORT=51820 #보류
      - PEERS=0
      - PEERDNS=auto
      - INTERNAL_SUBNET=10.13.13.0
      - ALLOWEDIPS=0.0.0.0/0 #a4
    volumes:
      - ${appDataDirectory}\\config:/config #자동
      - ${appDataDirectory}\\modules:/lib/modules #자동
    ports:
      - 51820:51820/udp #보류
    sysctls:
      - net.ipv4.conf.all.src_valid_mark=1
    restart: unless-stopped
''';

    // Compose 파일 저장 경로
    final composeFile = File('$appDataDirectory\\docker-compose.yml');

    // 파일 저장
    await composeFile.writeAsString(composeContent);

    print('docker-compose.yml 파일 생성 완료: ${composeFile.path}');
  }
}
