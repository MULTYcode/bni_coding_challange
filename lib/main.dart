import 'package:bni_coding_challange/app.dart';
import 'package:bni_coding_challange/src/features/home/presentation/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // final isItDark = await isDark();
  runApp(BlocProvider(
    create: (context) => HomeBloc()..add(SetInitialTheme(isDark: true)),
    child: const App(),
  ));
}
