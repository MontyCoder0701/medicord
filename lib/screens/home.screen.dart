import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../providers/providers.dart';
import 'splash.screen.dart';

class HomeScreen extends StatefulWidget {
  final Widget child;

  const HomeScreen({
    required this.child,
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final Future _future;
  late final recordProvider = context.read<RecordProvider>();
  late int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _future = _initializeResources();
  }

  Future<void> _initializeResources() async {
    recordProvider.getMany();
  }

  void _handleTabSelect(int index) {
    switch (index) {
      case 0:
        context.go('/record');
        break;
      case 1:
        context.go('/stat');
        break;
    }
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _future,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SplashScreen();
        } else {
          return Scaffold(
            appBar: AppBar(title: const Text('MediCord')),
            body: widget.child,
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
              onTap: (index) => _handleTabSelect(index),
            ),
          );
        }
      },
    );
  }
}
