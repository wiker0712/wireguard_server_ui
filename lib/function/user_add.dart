import 'package:flutter/material.dart';
import 'dart:io';


Future<void> userAdd(String userName, String serverIp, String clientIp) async
{
  try {
    // Define the commands to execute
    List<String> commands = [
      'docker exec -it WireGuard bash',
      'mkdir -p /config/$userName',
      'wg genkey | tee /config/$userName/privatekey-$userName | wg pubkey > /config/$userName/publickey-$userName',
      'wg genpsk > /config/$userName/presharedkey-$userName',
      "cat << EOF > /config/$userName/$userName.conf\n" +
          "[Interface]\n" +
          "Address = $clientIp\n" +
          "PrivateKey = \$(cat /config/$userName/privatekey-$userName)\n" +
          "ListenPort = 51820\n" +
          "DNS = 10.13.13.1\n\n" +
          "[Peer]\n" +
          "PublicKey = \$(cat /config/server/publickey-server)\n" +
          "PresharedKey = \$(cat /config/$userName/presharedkey-$userName)\n" +
          "Endpoint = $serverIp:51820\n" +
          "AllowedIPs = 0.0.0.0/0\n" +
          "EOF",
      'qrencode -o /config/$userName/$userName.png < /config/$userName/$userName.conf',
      "cat << EOF >> /config/wg_confs/wg0.conf\n" +
          "[Peer]\n" +
          "# $userName 클라이언트 설정\n" +
          "PublicKey = \$(cat /config/$userName/publickey-$userName)\n" +
          "PresharedKey = \$(cat /config/$userName/presharedkey-$userName)\n" +
          "AllowedIPs = $clientIp\n" +
          "EOF",
      'wg-quick down wg0 && wg-quick up wg0'
    ];

    for (var command in commands) {
      // Execute each command
      await Process.run('bash', ['-c', command]);
    }

    // Show success message

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('User $userName added successfully!')),
    );
  } catch (e) {
    // Show error message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error adding user: $e')),
    );
  }
}



//클라이언트 파일
//address 10.13.13.2 부터 시작 10.13.13.1은 서버

//서버 파일
//address 10.13.13.1

//peer
// allowedIPs peer의 address 10.3.13.2/32
