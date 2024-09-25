part of 'home_page_bloc.dart';

@immutable
sealed class HomePageState {}

final class HomePageInitial extends HomePageState {}

class WebSocketLoading extends HomePageState {}

class WebSocketLoaded extends HomePageState {
  final dynamic data;

  WebSocketLoaded(this.data);
}

class WebSocketError extends HomePageState {
  final String error;

  WebSocketError(this.error);
}
