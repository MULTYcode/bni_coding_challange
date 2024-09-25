import 'package:bni_coding_challange/src/features/chart/presentation/bloc/chart_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../models/chart_data.dart';

class ChartPage extends StatefulWidget {
  final String symbolTitle;
  const ChartPage({super.key, required this.symbolTitle});

  @override
  State<ChartPage> createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.symbolTitle)),
      body: BlocBuilder<ChartBloc, ChartState>(
        builder: (context, state) {
          if (state is ChartLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ChartLoaded) {
            return WebViewWidget(controller: state.data);
            // return WebViewWidget(
            //   controller: state.data,
            // );
            // return SfCartesianChart(
            //   primaryXAxis: const CategoryAxis(),
            //   title: const ChartTitle(text: 'Stock Chart'),
            //   legend: const Legend(isVisible: true),
            //   tooltipBehavior: TooltipBehavior(enable: true),
            //   series: <CartesianSeries<ChartData, String>>[
            //     LineSeries<ChartData, String>(
            //       dataSource: state.data,
            //       xValueMapper: (ChartData data, _) => data.year,
            //       yValueMapper: (ChartData data, _) => data.sales,
            //       name: 'Sales',
            //       dataLabelSettings: const DataLabelSettings(isVisible: true),
            //     ),
            //   ],
            // );
          } else {
            return const Center(child: Text('Something went wrong'));
          }
        },
      ),
    );
  }
}
