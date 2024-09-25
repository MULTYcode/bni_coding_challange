part of 'chart_bloc.dart';

@immutable
sealed class ChartEvent {}

class ChartDataInitial extends ChartEvent {}

class ChartDataEvent extends ChartEvent {
  final dynamic data;
  ChartDataEvent(this.data);
}
