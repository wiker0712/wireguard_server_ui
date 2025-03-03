import 'dart:io';

class GlobalState {
  static final GlobalState _instance = GlobalState._internal();
  factory GlobalState() => _instance;
  GlobalState._internal();

  Directory? currentDirectory;
  String serverIP = "192.0.0.1";
  String containerName = "test";

  Directory getDirectory(String containerName) {
    return Directory('${Platform.environment['APPDATA']}\\wireguardserverui\\$containerName');
  }

  String getServerIp() {
    return serverIP;
  }
}