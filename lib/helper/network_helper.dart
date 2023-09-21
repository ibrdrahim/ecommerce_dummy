import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ecommerce_dummy/bloc/network/network_bloc.dart';

class NetworkHelper {
  static void observeNetwork() {
    // Handle network response.
    void handleNetworkResponse(ConnectivityResult connectivityResult) {
      if (connectivityResult == ConnectivityResult.none) {
        NetworkBloc().add(NetworkNotify());
      } else {
        NetworkBloc().add(NetworkNotify(isConnected: true));
      }
    }

    // Check connectivity once, for the initial state.
    Connectivity().checkConnectivity().then((ConnectivityResult result) {
      handleNetworkResponse(result);
    });
    // Listen to connectivity changes.
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      handleNetworkResponse(result);
    });
  }
}
