import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('Dashboard',
            style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold)),
        Spacer(),
        Expanded(child: SearchField()),
      ],
    );
  }
}

class SearchField extends StatelessWidget {
  const SearchField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
          hintText: "Search",
          fillColor: Colors.grey[240],
          filled: true,
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          suffixIcon: Container(
            padding: EdgeInsets.all(16.0 * 0.75),
            decoration: BoxDecoration(color: Colors.grey[240]),
            child: Icon(Icons.search),
          )),
    );
  }
}
