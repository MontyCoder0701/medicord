import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../providers/providers.dart';
import 'splash.screen.dart';

class HomeScreen extends StatefulWidget {
  final StatefulNavigationShell shell;

  const HomeScreen({
    required this.shell,
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final Future _future;
  late final recordProvider = context.read<RecordListProvider>();
  late int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _future = _initializeResources();
  }

  Future<void> _initializeResources() async {
    recordProvider.getMany();
  }

  void _goBranch(int index) {
    setState(() => _selectedIndex = index);
    widget.shell.goBranch(
      index,
      initialLocation: index == widget.shell.currentIndex,
    );
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
            body: widget.shell,
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
              onTap: (index) => _goBranch(index),
            ),
          );
        }
      },
    );
  }
}
