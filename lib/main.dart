import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app_task/view/screen/biometric_auth_page.dart';
import 'package:note_app_task/view/screen/home.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Task Manager',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home:  BiometricAuthPage(),
    );
  }
}
