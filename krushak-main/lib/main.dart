import 'dart:ui';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:krushak/provider/internet_provider.dart';
import 'package:krushak/provider/sign_in_provider.dart';
import 'package:krushak/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:krushak/theme/app_translations.dart';


void main() async {
  // initialize the application
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: ((context) => SignInProvider()),
        ),
        ChangeNotifierProvider(
          create: ((context) => InternetProvider()),
        ),
      ],
      child:  GetMaterialApp(
        home: SplashScreen(),
        debugShowCheckedModeBanner: false,
        translations: AppTranslation(),
        locale: Locale('en', 'US'),
        fallbackLocale: Locale('en', 'US'),
      ),
    );
  }
}