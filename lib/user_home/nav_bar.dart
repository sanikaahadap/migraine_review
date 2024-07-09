import 'package:flutter/material.dart';
import 'package:neurooooo/user_home/home.dart';
import 'package:neurooooo/user_home/trigger_notifs.dart';
import 'package:neurooooo/user_home/instruction_manual.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({Key? key}) : super(key: key);

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int selectedIndex = 0;
  late DateTime currentBackPressTime;

  final List<Widget> _pages = [
    const HomePage(),
    const AnalysisPage(),
    const InstructionManualPage(),
  ];

  @override
  void initState() {
    super.initState();
    currentBackPressTime = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PopScope(
        canPop: false,
        child: _pages[selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF16666B),
        onTap: _navigate,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.help_outlined),
            label: 'Instructions',
          ),
        ],
      ),
    );
  }

  void _navigate(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
}
