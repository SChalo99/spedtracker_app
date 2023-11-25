import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:spedtracker_app/components/alerts/alert_config.dart';
import 'package:spedtracker_app/components/alerts/factory/abstract_factory.dart';
import 'package:spedtracker_app/components/alerts/factory/andoid_factory.dart';
import 'package:spedtracker_app/components/alerts/factory/ios_factory.dart';
import 'package:spedtracker_app/components/alerts/system_alert.dart';
import 'package:spedtracker_app/firebase_options.dart';
import 'package:spedtracker_app/screens/splash/splash_screen.dart';
import 'package:spedtracker_app/services/fcm_service.dart';
import 'package:spedtracker_app/services/notification_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await NotificationService().init();
  await FCMService().init();
  _systemAlerts();
  runApp(const MyApp());
  NotificationService().createNotification('SpendTracker',
      'Gestiona todos tus movimientos bancarios en una sola aplicación');

}

void _systemAlerts() {
  AlertConfig config = AlertConfig.instance;
  AbstractFactory factory;
  if (Platform.isAndroid) {
    factory = AndroidFactory();
  } else {
    factory = IOSFactory();
  }
  SystemAlert alert = SystemAlert(factory);
  config.systemAlert = alert;
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Brightness isDarkMode =
        SchedulerBinding.instance.platformDispatcher.platformBrightness;
    if (isDarkMode == Brightness.dark) {}
    return MaterialApp(
      title: 'SpendTracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        /* light theme settings */
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        /* dark theme settings */
      ),
      themeMode: ThemeMode.system,
      home: const SplashScreen(),
    );
  }
}
