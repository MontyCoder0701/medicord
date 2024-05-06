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
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const ChartDetailScreen(detailKey: 'PCD'),
                    ),
                  );
                },
                child: Column(
                  children: [
                    const Text('PCD'),
                    AspectRatio(
                      aspectRatio: 2,
                      child: LineChart(
                        LineChartData(
                          lineTouchData: const LineTouchData(enabled: false),
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
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const ChartDetailScreen(detailKey: 'PTBD'),
                    ),
                  );
                },
                child: Column(
                  children: [
                    const Text('PTBD'),
                    AspectRatio(
                      aspectRatio: 2,
                      child: LineChart(
                        LineChartData(
                          lineTouchData: const LineTouchData(enabled: false),
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
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const ChartDetailScreen(detailKey: '몸무게'),
                    ),
                  );
                },
                child: Column(
                  children: [
                    const Text('몸무게'),
                    AspectRatio(
                      aspectRatio: 2,
                      child: LineChart(
                        LineChartData(
                          lineTouchData: const LineTouchData(enabled: false),
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
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const ChartDetailScreen(detailKey: '최고 혈압'),
                    ),
                  );
                },
                child: Column(
                  children: [
                    const Text('최고 혈압'),
                    AspectRatio(
                      aspectRatio: 2,
                      child: LineChart(
                        LineChartData(
                          lineTouchData: const LineTouchData(enabled: false),
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
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const ChartDetailScreen(detailKey: '최저 혈압'),
                    ),
                  );
                },
                child: Column(
                  children: [
                    const Text('최저 혈압'),
                    AspectRatio(
                      aspectRatio: 2,
                      child: LineChart(
                        LineChartData(
                          lineTouchData: const LineTouchData(enabled: false),
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
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const ChartDetailScreen(detailKey: '체온'),
                    ),
                  );
                },
                child: Column(
                  children: [
                    const Text('체온'),
                    AspectRatio(
                      aspectRatio: 2,
                      child: LineChart(
                        LineChartData(
                          lineTouchData: const LineTouchData(enabled: false),
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
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
