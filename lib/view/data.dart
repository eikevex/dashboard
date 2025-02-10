import 'package:dashborad/controllers/filterControllers.dart';
import 'package:dashborad/controllers/reviewsController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class DataTest extends StatefulWidget {
  const DataTest({super.key});

  @override
  State<DataTest> createState() => _DataTestState();
}

class _DataTestState extends State<DataTest> {
  final ReviewsController _controllerReviews = Get.put(ReviewsController());
  final FilterController _controllerAgencys = Get.put(FilterController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(() {
        if (_controllerReviews.isLoading.value) {
          return CircularProgressIndicator();
        } else if (_controllerReviews.reviews.isEmpty) {
          return Center(child: Text('Nenhuma review encontrada.'));
        } else {
          return Column(children: [
            Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Container(
                    height: 600,
                    color: Colors.blueGrey,
                    child: Center(
                      child: Text(
                        'Total de Indicações: ${_controllerReviews.totalIndication.value}',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                Expanded(
                  flex: 5,
                  child: Container(
                    height: 600,
                    color: Colors.blueGrey,
                    child: Center(
                      child: Text(
                        'Total de Indicações: ${_controllerReviews.totalIndicationDoc.value} Média de indicações? ${_controllerReviews.averageIndication.value}',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                Expanded(
                    flex: 5,
                    child: Container(
                      height: 600,
                      color: Colors.blueGrey,
                      child: ListView.builder(
                        itemCount: _controllerAgencys.agencys.length,
                        itemBuilder: (context, index) {
                          final agency = _controllerAgencys.agencys[index];
                          return Text('Agency: ${agency.name}');
                        },
                      ),
                    ))
              ],
            )
          ]);
        }
      }),
    );
  }
}
