
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:spedtracker_app/services/notification_service.dart';

class FCMService {
  

  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  Future<void> init() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint('Got a message whilst in the foreground!');
      debugPrint('Message data: ${message.data}');

      if (message.notification != null) {
        NotificationService().createNotification(
            message.notification!.title!, message.notification!.body!);

        debugPrint(
            'Message also contained a notification: ${message.notification}');
      }
    });

    FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  }
  
  
  Future<String?> getFCMToken() async {
    String? token = await _fcm.getToken();
    debugPrint(token!);
    return token;
  }

}
/*3
Future<void> backgroundHandler(RemoteMessage message) async {
  debugPrint('Handling a background message ${message.messageId}');
}
3*/
