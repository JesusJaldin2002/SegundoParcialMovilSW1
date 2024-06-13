import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:segundo_parcial_movil_sw1/src/config/environment/environment.dart';
import 'package:segundo_parcial_movil_sw1/src/config/theme/app_theme.dart';
import 'package:segundo_parcial_movil_sw1/src/screens/screens.dart';
import 'package:segundo_parcial_movil_sw1/src/screens/students/students_screen.dart';

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
      title: 'College',
      debugShowCheckedModeBanner: false,
      theme: AppTheme().getTheme(),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => LoginScreen()),
        GetPage(name: '/home', page: () => const HomeScreen()),
        GetPage(name: '/courses', page: () =>  CoursesScreen()),
        GetPage(
          name: '/create-notice/:id',
          page: () => CreateNoticeScreen(id: int.parse(Get.parameters['id']!)),
        ),
        GetPage(
          name: '/notices/:id',
          page: () => NoticesScreen(id: int.parse(Get.parameters['id']!)),
        ),
        GetPage(
          name: '/events/:id',
          page: () => EventsScreen(id: int.parse(Get.parameters['id']!)),
        ),
        GetPage(
          name: '/agenda/:id',
          page: () => StudentsScreen(id: int.parse(Get.parameters['id']!)),
        ),
      ],
      navigatorKey: Get.key,
    );
  }
}
