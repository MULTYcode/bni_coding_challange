import 'package:flutter/material.dart';

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
      body: Center(
        child: Text('Chart'),
      ),
    );
  }
}
