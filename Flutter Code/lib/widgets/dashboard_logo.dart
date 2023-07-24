import 'package:flutter/material.dart';

class DashboardLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/school-logo.png',
      width: 100, // Adjust the width as needed
      height: 100, // Adjust the height as needed
      fit: BoxFit.contain,
    );
  }
}
