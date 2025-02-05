import 'package:dashborad/controllers/dashBoardController.dart';
import 'package:dashborad/pages/auth.dart';
import 'package:dashborad/pages/dashboard.dart';
import 'package:dashborad/widgets/background.dart';
import 'package:dashborad/widgets/sideMenu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DashboardController controller = DashboardController();
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    controller.fetchUserRole();
  }

  void _onDestinationSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 0) {
    } else if (index == 1) {
    } else if (index == 2) {
      logout();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: SafeArea(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SideMenu(),
              ),
              Expanded(flex: 5, child: Dashboard()),
            ],
          ),
        ),
      ),
    );
  }
}
