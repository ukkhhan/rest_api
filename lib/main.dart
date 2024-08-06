import 'package:flutter/material.dart';
import 'package:rest_api/Home_Screen.dart';
import 'package:rest_api/Home_Screen2.dart';
import 'package:rest_api/Home_Screen3.dart';
import 'package:rest_api/Upload_Image.dart';
import 'package:rest_api/multi_complex_json.dart';
import 'package:rest_api/complex_json.dart';
import 'package:rest_api/signup_api.dart';
import 'package:rest_api/signinn_api.dart';
import 'package:rest_api/temp_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const UploadImage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
