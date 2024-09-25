import 'dart:convert';

import 'package:bni_coding_challange/src/features/home/domain/repositories/websocket_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_page_event.dart';
part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  final WebSocketRepository repository;

  final dataMap = [
    {
      "img": 'assets/images/eth.png',
      "s": 'ETH-USD',
      "p": 0.0,
      'dd': 0.0,
      'dc': 0.0
    },
    {
      "img": 'assets/images/btc.png',
      "s": 'BTC-USD',
      "p": 0,
      'dd': 0.0,
      'dc': 0.0
    },
  ];

  HomePageBloc(this.repository) : super(HomePageInitial()) {
    on<HomePageEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<ConnectToWebSocket>((event, emit) async {
      emit(WebSocketLoading());
      try {
        await emit.forEach(
          repository.dataStream,
          onData: (data) {
            if (data != null) {
              repository.send(
                  '{"action": "subscribe", "symbols": "ETH-USD,BTC-USD"}');
            } else {
              emit(WebSocketError("Failed to receive data"));
            }

            Map getData = jsonDecode(data);
            getData.forEach((key, value) {
              if (value == 'ETH-USD' || value == 'BTC-USD') {
                var x = dataMap.indexWhere((element) => element['s'] == value);
                dataMap[x]['p'] = getData['p'];
                dataMap[x]['dd'] = getData['dd'];
                dataMap[x]['dc'] = getData['dc'];
              }
            });

            return WebSocketLoaded(dataMap);
          },
          onError: (_, __) => WebSocketError("Failed to receive data"),
        );
      } catch (e) {
        emit(WebSocketError(e.toString()));
      }
    });

    on<ReceiveWebSocketData>((event, emit) {
      emit(WebSocketLoaded(event.data));
    });
  }

  @override
  Future<void> close() {
    repository.dispose();
    return super.close();
  }
}
