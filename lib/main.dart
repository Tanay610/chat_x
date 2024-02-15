import 'dart:async';

import 'package:chat_x/bindings/splash_binding.dart';
import 'package:chat_x/controllers/auth_controller.dart';
import 'package:chat_x/firebase_options.dart';
import 'package:chat_x/routes/x_pages.dart';
import 'package:chat_x/view/pages/splash_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
   AuthController authController = Get.put(AuthController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key,});


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.intital,
      getPages: AppPages.routes,
      initialBinding: SplashBinding(),
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const SplashPage(),
    );
  }
}
