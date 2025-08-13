import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
part 'check_internet_state.dart';

class CheckInternetCubit extends Cubit<CheckInternetState> {
  final Connectivity _connectivity;
  final InternetConnectionChecker _internetChecker;
  StreamSubscription<List<ConnectivityResult>>? _sub;
  Timer? _debounceTimer;

  CheckInternetCubit(this._connectivity, this._internetChecker)
      : super(ConnectivityInitial()) {
    _startMonitoring();
  }

  void _startMonitoring() {
    _sub = _connectivity.onConnectivityChanged.listen((results) {
      final result = results.isNotEmpty
          ? results.first
          : ConnectivityResult.none;
      _debounceTimer?.cancel();
      _debounceTimer = Timer(const Duration(milliseconds: 500), () {
        _checkAndEmitFromResult(result);
      });
    });
  }

  Future<void> _checkAndEmitFromResult(ConnectivityResult connectivityResult) async {
    try {
      if (connectivityResult == ConnectivityResult.none) {
        emit(ConnectivityDisconnected());
        return;
      }

      final hasInternet = await _internetChecker.hasConnection;
      if (hasInternet) {
        emit(ConnectivityConnected());
      } else {
        emit(ConnectivityDisconnected());
      }
    } catch (_) {
      emit(ConnectivityDisconnected());
    }
  }

  @override
  Future<void> close() {
    _sub?.cancel();
    _debounceTimer?.cancel();
    return super.close();
  }
}
