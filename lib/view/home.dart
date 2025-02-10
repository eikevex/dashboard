import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashborad/controllers/dashBoardController.dart';
import 'package:dashborad/view/dashboard.dart';
import 'package:dashborad/view/data.dart';
import 'package:dashborad/utils/responsive.dart';
import 'package:dashborad/widgets/background.dart';
import 'package:dashborad/widgets/sideMenu.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: SafeArea(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (Responsive.isDesktop(context))
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
