import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/providers.dart';
import 'chart_detail.dart';

class ChartListScreen extends StatefulWidget {
  const ChartListScreen({super.key});

  @override
  State<ChartListScreen> createState() => _ChartListScreenState();
}

class _ChartListScreenState extends State<ChartListScreen> {
  late final _recordProvider = context.read<RecordProvider>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text('이번달 추세'),
              const SizedBox(height: 10.0),
              _buildChart(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const ChartDetailScreen(detailKey: 'PCD'),
                    ),
                  );
                },
                title: 'PCD',
                lineBarsData: [
                  LineChartBarData(
                    spots: _recordProvider.currentMonthRecords
                        .map(
                          (e) => FlSpot(
                            e.createdAt.day.toDouble(),
                            e.pcd,
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
              _buildChart(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const ChartDetailScreen(detailKey: 'PTBD'),
                    ),
                  );
                },
                title: 'PTBD',
                lineBarsData: [
                  LineChartBarData(
                    spots: _recordProvider.currentMonthRecords
                        .map(
                          (e) => FlSpot(
                            e.createdAt.day.toDouble(),
                            e.ptbd,
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
              _buildChart(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const ChartDetailScreen(detailKey: '몸무게'),
                    ),
                  );
                },
                title: '몸무게',
                lineBarsData: [
                  LineChartBarData(
                    spots: _recordProvider.currentMonthRecords
                        .map(
                          (e) => FlSpot(
                            e.createdAt.day.toDouble(),
                            e.weight,
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
              _buildChart(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const ChartDetailScreen(detailKey: '최고 혈압'),
                    ),
                  );
                },
                title: '최고 혈압',
                lineBarsData: [
                  LineChartBarData(
                    spots: _recordProvider.currentMonthRecords
                        .map(
                          (e) => FlSpot(
                            e.createdAt.day.toDouble(),
                            e.bpMax,
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
              _buildChart(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const ChartDetailScreen(detailKey: '최저 혈압'),
                    ),
                  );
                },
                title: '최저 혈압',
                lineBarsData: [
                  LineChartBarData(
                    spots: _recordProvider.currentMonthRecords
                        .map(
                          (e) => FlSpot(
                            e.createdAt.day.toDouble(),
                            e.bpMin,
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
              _buildChart(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const ChartDetailScreen(detailKey: '체온'),
                    ),
                  );
                },
                title: '체온',
                lineBarsData: [
                  LineChartBarData(
                    spots: _recordProvider.currentMonthRecords
                        .map(
                          (e) => FlSpot(
                            e.createdAt.day.toDouble(),
                            e.temp,
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChart({
    required Function() onTap,
    required String title,
    required List<LineChartBarData> lineBarsData,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Column(
          children: [
            Text(title),
            AspectRatio(
              aspectRatio: 2.5,
              child: LineChart(
                LineChartData(
                  titlesData: const FlTitlesData(
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                      ),
                    ),
                  ),
                  lineTouchData: const LineTouchData(enabled: false),
                  lineBarsData: lineBarsData,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
