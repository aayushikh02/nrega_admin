import 'dart:async';
import 'package:connectivity/connectivity.dart';

class Connection {
  static Future<ConnectivityResult> checkInternetConnection() {
    return Connectivity().checkConnectivity();
  }

  static internet() async {
    bool internetConnection;
    Future<ConnectivityResult> _conRes = Connection.checkInternetConnection();
    await _conRes.then((onResult) {
      if (onResult == ConnectivityResult.none) {
        internetConnection = false;
        return internetConnection;
      } else {
        internetConnection = true;
        return internetConnection;
      }
    });
    return internetConnection;
  }
}
