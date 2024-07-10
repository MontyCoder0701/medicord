import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/providers.dart';
import 'record/record.dart';
import 'splash.screen.dart';
import 'stat/stat.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final recordProvider = context.read<RecordProvider>();
  int _selectedIndex = 0;
  final List<Widget> _mainScreens = [
    const RecordListScreen(),
    const StatScreen(),
  ];

  Future<void> _initializeResources() async {
    recordProvider.getMany();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeResources(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SplashScreen();
        } else {
          return Scaffold(
            appBar: AppBar(title: const Text('MediCord')),
            body: _mainScreens[_selectedIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: _selectedIndex,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.medical_services_outlined),
                  label: '기록',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.calendar_month_outlined),
                  label: '달력',
                ),
              ],
              onTap: (index) => setState(() {
                _selectedIndex = index;
              }),
            ),
          );
        }
      },
    );
  }
}
