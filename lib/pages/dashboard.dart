import 'package:dashborad/constructors/cards.dart';
import 'package:dashborad/utils/displayMounth.dart';
import 'package:dashborad/widgets/charts.dart';
import 'package:dashborad/widgets/header.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<double> monthlyData = [10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65];
  int? touchedIndex;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Header(),
            SizedBox(
              height: 16.0,
            ),
            Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Container(
                    height: 500,
                    color: Colors.white60,
                  ),
                ),
                SizedBox(
                  width: 16.0,
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: EdgeInsets.all(16.0),
                    height: 500,
                    decoration: BoxDecoration(
                      color: Colors.white60,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "Avaliações",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: 16.0,
                        ),
                        PieChartWidget(
                          monthlyData: monthlyData,
                          onTouch: (index) {
                            setState(() {
                              touchedIndex = index;
                            });
                          },
                        ),
                        if (touchedIndex != null)
                          DisplayMounth(
                              touchedIndex: touchedIndex,
                              monthlyData: monthlyData),
                        Cards(
                          icon: Icon(
                            Icons.close,
                            color: Colors.red,
                          ),
                          title: 'Negativas',
                          color: Colors.red,
                          amount: '132',
                        ),
                        Cards(
                          title: 'Positivas',
                          color: Colors.green,
                          icon: Icon(
                            Icons.check_sharp,
                            color: Colors.green,
                          ),
                          amount: '200',
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
