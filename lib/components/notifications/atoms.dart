import 'package:flutter/material.dart';
import 'package:spedtracker_app/models/notification_model.dart';

class NotificationAtom extends StatelessWidget {
  final List<NotificationModel> notifications;

  const NotificationAtom({
    super.key,
    required this.notifications,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          NotificationModel notification = notifications[index];
          return Card(
            child: ListTile(
              title: Text(notification.asunto),
              subtitle: Text(notification.descripcion),
            ),
          );
        });
  }
}
