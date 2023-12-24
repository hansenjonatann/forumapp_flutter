import 'package:flutter/material.dart';
import 'package:forum_app/views/home.dart';
import 'package:forum_app/views/login_page.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get_storage/get_storage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final token = box.read('token');
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: token == null ? LoginPage() : HomePage(),
    );
  }
}
