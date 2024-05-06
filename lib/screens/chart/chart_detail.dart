import 'package:flutter/material.dart';

class ChartDetailScreen extends StatefulWidget {
  final String detailKey;

  const ChartDetailScreen({required this.detailKey, super.key});

  @override
  State<ChartDetailScreen> createState() => _ChartDetailScreenState();
}

class _ChartDetailScreenState extends State<ChartDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.detailKey),
      ),
      body: Center(),
    );
  }
}
