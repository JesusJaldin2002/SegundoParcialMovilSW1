import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:segundo_parcial_movil_sw1/src/config/environment/environment.dart';
import 'package:segundo_parcial_movil_sw1/src/config/theme/app_theme.dart';
import 'package:segundo_parcial_movil_sw1/src/screens/screens.dart';

void main() async {
  await Environment.initEnvironment();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'AutoFix',
      debugShowCheckedModeBanner: false,
      theme: AppTheme().getTheme(),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => LoginScreen()),
        GetPage(name: '/home', page: () => const HomeScreen()),

      ],
      navigatorKey: Get.key,
    );
  }
}
