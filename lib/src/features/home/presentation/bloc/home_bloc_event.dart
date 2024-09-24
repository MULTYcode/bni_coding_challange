part of 'home_bloc.dart';

@immutable
sealed class HomeBlocEvent {}

class SetInitialTheme extends HomeBlocEvent {
  final bool isDark;

  SetInitialTheme({required this.isDark});
}

class SwitchingTheme extends HomeBlocEvent {
  final bool isDark;

  SwitchingTheme({required this.isDark});
}
