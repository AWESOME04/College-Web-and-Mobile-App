import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          'assets/school-logo.png',
          width: 200,
          height: 200,
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
