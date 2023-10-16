import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class FCMService {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  Future<void> init() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  }

  Future<void> backgroundHandler(RemoteMessage message) async {
    debugPrint('Handling a background message ${message.messageId}');
  }

  Future<String?> getFCMToken() async {
    String? token = await _fcm.getToken();
    debugPrint(token!);
    return token;
  }
}
