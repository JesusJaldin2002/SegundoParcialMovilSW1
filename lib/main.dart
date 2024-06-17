// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:segundo_parcial_movil_sw1/src/config/environment/environment.dart';
import 'package:segundo_parcial_movil_sw1/src/config/theme/app_theme.dart';
import 'package:segundo_parcial_movil_sw1/src/screens/screens.dart';
import 'package:segundo_parcial_movil_sw1/src/screens/students/students_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  await Environment.initEnvironment();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Configuración de notificaciones locales
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  // ignore: prefer_const_constructors
  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  messaging.getToken().then((token) {
    print('Token: $token');
  });

  // ignore: unused_local_variable
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
      _showNotification(message.notification);
    }
  });

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(const MyApp());
}

Future<void> _showNotification(RemoteNotification? notification) async {
  if (notification != null) {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      channelDescription: 'your_channel_description',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      notification.title,
      notification.body,
      platformChannelSpecifics,
      payload: 'item x',
    );
  }
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

    // Configura Firebase Messaging
    FirebaseMessaging.instance.getInitialMessage();

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      if (message.data['route'] != null) {
        Get.toNamed(message.data['route']);
      }
    });
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
        GetPage(
            name: '/home',
            page: () => const HomeScreen(),
            middlewares: [AuthMiddleware()]),
        GetPage(
            name: '/courses',
            page: () => CoursesScreen(),
            middlewares: [AuthMiddleware()]),
        GetPage(
            name: '/create-notice/:id',
            page: () =>
                CreateNoticeScreen(id: int.parse(Get.parameters['id']!)),
            middlewares: [AuthMiddleware()]),
        GetPage(
            name: '/notices/:id',
            page: () => NoticesScreen(id: int.parse(Get.parameters['id']!)),
            middlewares: [AuthMiddleware()]),
        GetPage(
            name: '/events/:id',
            page: () => EventsScreen(id: int.parse(Get.parameters['id']!)),
            middlewares: [AuthMiddleware()]),
        GetPage(
            name: '/agenda/:id',
            page: () => StudentsScreen(id: int.parse(Get.parameters['id']!)),
            middlewares: [AuthMiddleware()]),
        GetPage(
            name: '/boletin/:id',
            page: () => BoletinScreen(id: int.parse(Get.parameters['id']!)),
            middlewares: [AuthMiddleware()]),
        GetPage(
            name: '/chatgpt',
            page: () => ChatScreen(),
            middlewares: [AuthMiddleware()]),
      ],
      navigatorKey: Get.key,
    );
  }
}

class AuthMiddleware extends GetMiddleware {
  @override
  Future<GetNavConfig?> redirectDelegate(GetNavConfig route) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isAuthenticated = prefs.getString('token') != null;

    if (!isAuthenticated) {
      // ignore: duplicate_ignore
      // ignore: avoid_print
      print('Not authenticated, redirecting to /login');
      return GetNavConfig.fromRoute('/login');
    }
    return null;
  }
}
