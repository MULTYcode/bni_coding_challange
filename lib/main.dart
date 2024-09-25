import 'package:bni_coding_challange/app.dart';
import 'package:bni_coding_challange/src/features/chart/presentation/bloc/chart_bloc.dart';
import 'package:bni_coding_challange/src/features/home/presentation/bloc/home_bloc.dart';
import 'package:bni_coding_challange/src/features/home/presentation/pages/bloc/home_page_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'src/features/home/domain/repositories/websocket_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // final isItDark = await isDark();
  final WebSocketRepository repository = WebSocketRepository(
      "wss://ws.eodhistoricaldata.com/ws/crypto?api_token=demo");
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<HomeBloc>(
        create: (context) => HomeBloc()..add(SetInitialTheme(isDark: true)),
      ),
      BlocProvider<HomePageBloc>(
        create: (context) =>
            HomePageBloc(repository)..add(ConnectToWebSocket()),
      ),
      BlocProvider<ChartBloc>(
        create: (context) => ChartBloc()..add(ChartDataInitial()),
      )
    ],
    child: const App(),
  ));
}
