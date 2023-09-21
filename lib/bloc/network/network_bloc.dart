import 'package:bloc/bloc.dart';
import 'package:ecommerce_dummy/helper/network_helper.dart';

part 'network_event.dart';
part 'network_state.dart';

class NetworkBloc extends Bloc<NetworkEvent, NetworkState> {
  NetworkBloc._() : super(NetworkInitial()) {
    on<NetworkObserve>(_observe);
    on<NetworkNotify>(_notifyStatus);
  }

  static final NetworkBloc _instance = NetworkBloc._();

  factory NetworkBloc() => _instance;

  /// Observe network status.
  void _observe(event, emit) {
    NetworkHelper.observeNetwork();
  }

  /// Notify network status.
  void _notifyStatus(NetworkNotify event, emit) {
    event.isConnected ? emit(NetworkSuccess()) : emit(NetworkFailure());
  }
}
