import 'package:dashborad/controllers/reviewsController.dart';
import 'package:dashborad/widgets/charts.dart';
import 'package:dashborad/widgets/filters.dart';
import 'package:dashborad/widgets/header.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<double> monthlyData = [10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65];
  List<double> assesmentData = [10, 15, 20];
  int? touchedIndex;

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      final reviewsController = context.read<ReviewsController>();
      await reviewsController
          .fetchUserReviews(FirebaseAuth.instance.currentUser!.uid);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Header(),
            SizedBox(height: 16.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white10,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Filters(),
                        SizedBox(height: 16.0),
                        BarChartWidget(),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 16.0),
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white60,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Avaliações',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 16.0),
                        PieChartWidget(
                          monthlyData: monthlyData,
                          onTouch: (index) {
                            setState(() {
                              touchedIndex = index;
                            });
                          },
                        ),
                        PieChartAssesment(
                          assesmentData: assesmentData,
                          onTouch: (index) {
                            setState(() {
                              touchedIndex = index;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
