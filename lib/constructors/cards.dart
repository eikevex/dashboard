import 'package:flutter/material.dart';

class Cards extends StatelessWidget {
  final String title, amount;
  final Icon icon;
  final Color color;

  const Cards({
    Key? key,
    required this.title,
    required this.icon,
    required this.amount,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 16.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: Colors.black.withOpacity(0.9),
          ),
          borderRadius: BorderRadius.all(Radius.circular(16.0))),
      child: Row(
        children: [
          SizedBox(
            height: 20,
            width: 20,
            child: icon,
          ),
          Expanded(
              child: Column(
            children: [
              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 17, fontWeight: FontWeight.bold, color: color),
              ),
              Text('$amount Avaliações', style: TextStyle(fontSize: 10))
            ],
          )),
        ],
      ),
    );
  }
}
