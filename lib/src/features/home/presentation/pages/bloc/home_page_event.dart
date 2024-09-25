part of 'home_page_bloc.dart';

@immutable
sealed class HomePageEvent {}

class ConnectToWebSocket extends HomePageEvent {}

class ReceiveWebSocketData extends HomePageEvent {
  final dynamic data;

  ReceiveWebSocketData(this.data);
}
