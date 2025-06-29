import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import '../../home/presentation/view/home_view.dart';
import '../../main.dart';
import 'local_notification_helper.dart';

class HuaweiMessageHelper {
  final LocalNotificationHelper localNotificationHelper =
      LocalNotificationHelper();
  String? userExternalId;
  String? oneSingleId;
  Future<void> initHuaweiNotification() async {
    await localNotificationHelper.initLocalNotification();
    await OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
    OneSignal.initialize("5db24dcc-36fd-4cd8-aab0-a88beedef515");
    OneSignal.Notifications.requestPermission(true);
    localNotificationHelper.handleForegroundNotification();
    userExternalId = await OneSignal.User.getExternalId();
    oneSingleId = await OneSignal.User.getOnesignalId();
    // handle foreground
    OneSignal.Notifications.addForegroundWillDisplayListener((event) {
      final notification = event.notification;
      log(
        "notification title = ${notification.title}  notification body = ${notification.body}",
      );
    });
    

    // handle notification clicked
    OneSignal.Notifications.addClickListener((action) {
      final body = action.notification.body;
      if (body != null) {
        handleNotificationData(body);
      }
    });
  }
  Future<void> sendHuaweiNotification({
      required String title,
      required String body,
    }) async {
      final dio = Dio();
      try {
        final response = dio.post(
          "https://api.onesignal.com/notifications?c=push",
          options: Options(
            headers: {'Authorization': "", 'Content-Type': 'application/json'},
          ),
          data: {
            "app_id": "5db24dcc-36fd-4cd8-aab0-a88beedef515",
            "include_aliases": {
              "external_id": [userExternalId],
              "onesignal_id": [oneSingleId],
            },
            "target_channel": "push",
            "contents": {"en": body},
            "headings": {"en": title},
          },
        );
        log("respose = $response");
      } on Exception catch (e) {
        log("error $e");
      }
    }

  Future<void> handleNotificationData(String body) async {
    final newStatus = body.trim().split(' ').last;

    await const FlutterSecureStorage().write(key: 'last', value: newStatus);
    navigatorKey.currentState?.pushReplacement(
      MaterialPageRoute(builder: (_) => const HomeView()),
    );
  }
}
