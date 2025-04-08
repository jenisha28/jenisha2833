import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class InternetChecker{
  StreamSubscription<List<ConnectivityResult>>? subscription;
  bool isInternetConnected = true;

  checkConnection() {
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> result) async {
      bool isConnected = await InternetConnectionChecker.instance.hasConnection;
        isInternetConnected = isConnected;
    });
  }
}