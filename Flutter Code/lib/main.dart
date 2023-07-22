import 'package:flutter/material.dart';
import 'package:ses_flutter_project/pages/login_page.dart';
import 'package:ses_flutter_project/pages/student_registration_page.dart';
import 'package:ses_flutter_project/pages/student_info_entry_page.dart';
import 'package:ses_flutter_project/pages/dashboard_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mobile System App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LogInPage(),
        '/studentRegistration': (context) =>
            StudentRegistrationPage(key: UniqueKey()),
        '/infoEntry': (context) => const StudentInfoEntryPage(),
        '/dashboard': (context) => DashboardPage(),
      },
    );
  }
}
