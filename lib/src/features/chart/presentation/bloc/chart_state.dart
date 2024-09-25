part of 'chart_bloc.dart';

@immutable
sealed class ChartState {}

final class ChartInitial extends ChartState {}

class ChartLoading extends ChartState {}

class ChartLoaded extends ChartState {
  final dynamic data;
  ChartLoaded(this.data);
}

class ChartError extends ChartState {
  final String message;
  ChartError(this.message);
}
