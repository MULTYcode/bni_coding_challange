import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'home_bloc_event.dart';
part 'home_bloc_state.dart';

class HomeBloc extends Bloc<HomeBlocEvent, ThemeData> {
  HomeBloc() : super(ThemeData.dark()) {
    on<HomeBlocEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<SetInitialTheme>((event, emit) async {
      setTheme(event.isDark);
      emit(event.isDark ? ThemeData.dark() : ThemeData.light());
    });
    on<SwitchingTheme>((event, emit) async {
      // debugPrint("swithing themes to ${event.isDark ? 'dark' : 'light'}");
      setTheme(!event.isDark);
      emit(event.isDark ? ThemeData.dark() : ThemeData.light());
    });
  }
}

Future<bool> isDark() async {
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  return sharedPreferences.getBool('is_dark') ?? false;
}

Future<void> setTheme(bool isDark) async {
  debugPrint("swithing themes to ${isDark ? 'dark' : 'light'}");
  return SharedPreferences.getInstance().then((value) {
    value.setBool('is_dark', isDark);
  });
}
