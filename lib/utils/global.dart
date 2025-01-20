import 'dart:io';

Directory? currentDirectory;
String serverIP = "192.0.0.1";

Directory getDirectory(String containerName) {
  return Directory('${Platform.environment['APPDATA']}\\wireguardserverui\\$containerName');
}

String getServerIp(){
  return serverIP;
}