part of 'check_internet_cubit.dart';

@immutable
abstract class CheckInternetState {}
class ConnectivityInitial extends CheckInternetState {}
class ConnectivityConnected extends CheckInternetState {}
class ConnectivityDisconnected extends CheckInternetState {}
