  import 'package:flutter/material.dart';

  class Background extends StatelessWidget {
    final Widget child;

    const Background({super.key, required this.child});

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/images/bg.png',
                fit: BoxFit.cover,
              ),
            ),
            Center(child: child)
          ],
        ),
      );
    }
  }
