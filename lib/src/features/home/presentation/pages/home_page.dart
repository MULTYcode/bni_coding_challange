import 'dart:convert';

import 'package:bni_coding_challange/src/features/home/presentation/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:web_socket_channel/io.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final channel = IOWebSocketChannel.connect(
      "wss://ws.eodhistoricaldata.com/ws/crypto?api_token=demo");

  final dataMap = [
    {
      "s": 'ETH-USD',
      "p": 0,
    },
    {
      "s": 'BTC-USD',
      "p": 0,
    },
  ];

  @override
  void initState() {
    super.initState();
    channel.sink.add('{"action": "subscribe", "symbols": "ETH-USD,BTC-USD"}');
    streamListener();
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }

  streamListener() {
    channel.stream.listen((event) {
      Map getData = jsonDecode(event);
      getData.forEach((key, value) {
        if (value == 'ETH-USD' || value == 'BTC-USD') {
          var x = dataMap.indexWhere((element) => element['s'] == value);
          // debugPrint(x.toString());
          setState(() {
            dataMap[x]['p'] = getData['p'];
          });
        }
      });
      // setState(() {});
      // debugPrint("Symbol : ${getData['s']}, Prices : ${getData['p']}");
      // debugPrint("Symbol : ${dataMap[0]['s']}, Prices : ${dataMap[0]['p']}");
    });
  }

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
      body: ListView.builder(
          itemBuilder: (_, index) => Card(
              elevation: 1,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                child: Row(
                  children: [
                    const Icon(Icons.currency_exchange_outlined),
                    SizedBox(width: 20.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${dataMap[index]['s']}",
                          style: TextStyle(fontSize: 16.sp),
                        ),
                        Text("${dataMap[index]['p']}")
                      ],
                    )
                  ],
                ),
              )),
          itemCount: dataMap.length),
    );
  }
}
