import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:studify/controllers/auth_controller.dart';
import 'package:studify/views/splash_screen.dart';
import 'dart:io' show Platform;
import 'package:studify/views/login_screen.dart';
import 'package:studify/views/signup_screen.dart';
import 'package:studify/views/home_screen.dart';
 Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Platform.isAndroid ?
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyDlEyB_6qU9FwvczzEooHMWAMp93psalNU',
          appId: '1:624478628744:android:6299b8eaf55a11a63c283d',
          messagingSenderId: '624478628744',
          projectId: 'studify-5f434',
          storageBucket: 'studify-5f434.appspot.com'
      ))
      .then((value) => Get.put(AuthController()))
       : Firebase.initializeApp();
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SplashScreen(),
    );
  }
}

