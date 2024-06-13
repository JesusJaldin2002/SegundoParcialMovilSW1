import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:segundo_parcial_movil_sw1/src/config/environment/environment.dart';
import 'package:segundo_parcial_movil_sw1/src/config/theme/app_theme.dart';
import 'package:segundo_parcial_movil_sw1/src/screens/screens.dart';
import 'package:segundo_parcial_movil_sw1/src/screens/students/students_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
        GetPage(name: '/home', page: () => const HomeScreen(), middlewares: [AuthMiddleware()]),
        GetPage(name: '/courses', page: () =>  CoursesScreen(), middlewares: [AuthMiddleware()]),
        GetPage(
          name: '/create-notice/:id',
          page: () => CreateNoticeScreen(id: int.parse(Get.parameters['id']!)),
          middlewares: [AuthMiddleware()]
        ),
        GetPage(
          name: '/notices/:id',
          page: () => NoticesScreen(id: int.parse(Get.parameters['id']!)),
          middlewares: [AuthMiddleware()]
        ),
        GetPage(
          name: '/events/:id',
          page: () => EventsScreen(id: int.parse(Get.parameters['id']!)),
          middlewares: [AuthMiddleware()]
        ),
        GetPage(
          name: '/agenda/:id',
          page: () => StudentsScreen(id: int.parse(Get.parameters['id']!)),
          middlewares: [AuthMiddleware()]
        ),
        GetPage(
          name: '/boletin/:id',
          page: () => BoletinScreen(id: int.parse(Get.parameters['id']!)),
          middlewares: [AuthMiddleware()]
        ),
        GetPage(name: '/chatgpt', page: () => ChatScreen(), middlewares: [AuthMiddleware()]),
      ],
      navigatorKey: Get.key,
    );
  }
}

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    SharedPreferences.getInstance().then((prefs) {
      bool isAuthenticated = prefs.getBool('isAuthenticated') ?? false;
      if (!isAuthenticated) {
        print('Not authenticated, redirecting to /');
        return const RouteSettings(name: '/');
      }
    });
    return null;
  }
}
