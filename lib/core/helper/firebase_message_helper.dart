import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseMessageHelper {
  final fcm = FirebaseMessaging.instance;

  Future<void> requestPermission() async {
    NotificationSettings settings = await fcm.requestPermission();
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      log("user granted permission");
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      log("User granted provisional permission");
    } else {
      log("user has not accepted permission");
    }
  }
}
