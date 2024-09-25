import 'package:bni_coding_challange/src/features/home/presentation/bloc/home_bloc.dart';
import 'package:bni_coding_challange/src/features/home/presentation/pages/bloc/home_page_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../chart/presentation/pages/chart_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BNI Code Challange'),
        actions: [
          BlocBuilder<HomeBloc, ThemeData>(
            builder: (context, state) {
              return IconButton(
                onPressed: () async => context
                    .read<HomeBloc>()
                    .add(SwitchingTheme(isDark: await isDark())),
                icon: Icon(state == ThemeData.light()
                    ? Icons.light_mode_outlined
                    : Icons.dark_mode_outlined),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<HomePageBloc, HomePageState>(
        builder: (context, state) {
          if (state is HomePageInitial) {
            return Center(
              child: Center(
                child: ElevatedButton(
                    onPressed: () {
                      context.read<HomePageBloc>().add(ConnectToWebSocket());
                    },
                    child: const Text('Connect to websocket')),
              ),
            );
          } else if (state is WebSocketLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is WebSocketError) {
            return Center(
              child: Text("Error: ${state.error}"),
            );
          } else if (state is WebSocketLoaded) {
            return ListView.builder(
                itemBuilder: (_, index) => GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChartPage(
                                symbolTitle: state.data[index]['s'],
                              ),
                            ));
                      },
                      child: Card(
                          elevation: 1,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.w, vertical: 10.h),
                            child: Row(
                              children: [
                                Image.asset('${state.data[index]['img']}',
                                    width: 50.w, height: 50.h),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "${state.data[index]['s']}",
                                            style: TextStyle(fontSize: 16.sp),
                                          ),
                                          Text(
                                            "${NumberFormat('#,##0.00').format(double.parse(state.data[index]['dc'].toString()))}%",
                                            style: TextStyle(
                                                fontSize: 16.sp,
                                                color: double.parse(state
                                                            .data[index]['dc']
                                                            .toString()) <
                                                        0
                                                    ? Colors.red
                                                    : Colors.green),
                                          ),
                                          IconButton(
                                              onPressed: () {},
                                              icon: const Icon(
                                                  Icons.info_outline,
                                                  color: Colors.grey))
                                        ],
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Text(
                                            "Last : ${NumberFormat('#,##0.00').format(double.parse(state.data[index]['p'].toString()))}",
                                          ),
                                          const Spacer(),
                                          SizedBox(
                                            child: Text(
                                              "Chg : ${NumberFormat('#,##0.00').format(double.parse(state.data[index]['dd'].toString()))}",
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )),
                    ),
                itemCount: state.data.length);
          }
          return Container();
        },
      ),
    );
  }
}
