import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/modules/home/controllers/home_controller.dart';
import 'app/routes/app_pages.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';


void main() async {


  WidgetsFlutterBinding.ensureInitialized();


// ...

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Get.put(HomeController());

  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
