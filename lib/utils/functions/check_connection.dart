import 'package:connectivity_plus/connectivity_plus.dart';

Future<bool> checkConnection() async {
  final ConnectivityResult result = await Connectivity().checkConnectivity();
  if (result == ConnectivityResult.mobile ||
      result == ConnectivityResult.wifi) {
    return true;
  } else {
    return false;
  }
}
