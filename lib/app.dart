import 'package:bni_coding_challange/src/features/home/presentation/bloc/home_bloc.dart';
import 'package:bni_coding_challange/src/features/home/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder: (context, child) => BlocBuilder<HomeBloc, ThemeData>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'BNI Challange Code',
            theme: state,
            home: child,
          );
        },
      ),
      child: const HomePage(),
    );
  }
}
