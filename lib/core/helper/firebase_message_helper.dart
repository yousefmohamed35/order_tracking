import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:ordertracking/core/helper/local_notification_helper.dart';
import 'package:ordertracking/core/models/notification_data.dart';
import 'package:ordertracking/core/models/notification_load.dart';
import '../../home/presentation/view/home_view.dart';
import '../../main.dart';
import '../models/notification_content.dart';

class FirebaseMessageHelper {
  final fcm = FirebaseMessaging.instance;
  final Dio dio = Dio();
  final LocalNotificationHelper localNotificationHelper =
      LocalNotificationHelper();
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

  Future<void> initNotification() async {
    await localNotificationHelper.initLocalNotification();
    await requestPermission();
    String? firebaseMessageToken = await fcm.getToken();
    log("firebase token: $firebaseMessageToken");
    localNotificationHelper.handleForegroundNotification();
    handelterminatedNotificationClick();
    handelBackgroundNotificationClick();
  }

  Future<String?> getAccessToken() async {
    final serviceJson = {
      "type": "service_account",
      "project_id": "ordertracking-f4874",
      "private_key_id": "9778b19fcc479690a0e8b3af060f7be2b8ac9fb5",
      "private_key":
          "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCr/GpgPbPa/lQH\nKIEiUUp7e7v1xFCoFW4VP+Z88eE69+v5KIGvY+FAW5bWzHYGlrQwclGWBmcMr72/\nDA4FW06uq4f/v9jVpcMWJNqbEuuAVV1asYdEFsxgxj8ibrVUEU6dbpknvAHnatA/\nOvgvzvl4SykPz5trykKvGy3Ug645wTEetk7djrKhsF08IIkbEmkRKgLXPIgf+DYG\nrOsZQdM0XB9LlMoWGCi2T4ZBJkhd5hnd4r9E7HTPND/CY4CF+Ep39s1nHF/rk2A/\nTK0RdUExJxVaViLcFm9UU5pXNpi0VLCCWLE7bA/lJpJi0Ftq3Z4dsggDxqj3IXFA\nCcyV/VPzAgMBAAECggEABz5YVJzoOhfgGpGFfQoVOhsS5mwZKKlcnx8pMVJr/O1f\nTkC0DLAjj+GvMx/lZgEydS4e+RrWJnpqKXO69+OtQ5LwHk71GPp5nvh4nXNo/ZIM\nnoHqSonaYxu2aQLYNu0Z5zOMK8o//rksSQ8/3hANyG08oNRKueuzitlcpI/Sygfb\n2i+gG9SzhUmZikj8hneGar9ejYELNOjNhPHOq52VvFwUeE27yvtsUPyZK1/gp/Zb\nVL/OA8z2QCLaORG5kOuT1SpXHKtXYglcB9zuFQrYKOMf2vbMs+htdg7tf7t3F432\nUOIjWcgwyIOxVhTOrQ33MbQcwb2IeVs9ygLtjkMgAQKBgQDsc0rkEvpkSUEK8Qit\nx8huedtWl1OuHdLICfeg+1UzYb13hpeCKoFcHEHaDMWZQWmBBo3onLoCOm7d/9gq\n3ASR+jUJ97wHgJYKomE4rupFsVTSnEgRyPrVoVk8PTM9UqTX9NXSh5T7jka5/n5w\nRP80ozjk6vTnTTzx9+nETU4b8wKBgQC6NKunEJ7LgziLiefXlXF39WRwuolsCVFU\nuMcCQuAcud0Bwm95MeGDv2rblxDGdPnETwNLmFGq2S1eWIzx9BWIuu7FZwdDVFo9\nPcaw5jKeKORO6jQFPZVx5ZoYz4ADh05PQFMtPChgLnmxr6hkCjZP887qXt4KesiG\noF+icPnoAQKBgCkHaHti/6ffPjYT1RmyjQj+hBzmbVLNQgIMGLgKZKJh12qiJDAm\nCARfst2PUcpiG1iUNpOifnRch1hmSLBHNVPPQtzT7ACxQ1fdDVm0oFovhzR0gdz0\nLvJa6Q0W4YlGiewfQ+sgM63i5krn6jC5CD+uAvVV/+ES+fxStHGnqGIZAoGAfngH\nnhDLya32Wc/wh5wY1UD2Vxpa++XYN5LIl+CUFu6mDOviio42fSUljr+rxR7uBUcl\nFdL+pOucxNef4zXE6nkMc0bmx/Qi1jV/Hec7ufBMIM0xR93sAs/POcq1R7A+n9Uw\nqSiSw8DNJsIHvOqyuNr/Tm/gn32FdOq4CbxyAAECgYEAg4pZ4sbqYhNsSKfwBMAZ\nIC03sc2Jj47U80BxbQ8iv89KkrJbF0kMYTbw6kSbxNjDAxI8piWe+sXNmt92InfT\ndUuycRUVU+Y+h8x0VJBD+0y9H/6X2nEj9joqnQkeCtuQzfIkCYaHSmu8/6fbGau4\nqh8MnNEnAioSD4qcqojqhLo=\n-----END PRIVATE KEY-----\n",
      "client_email":
          "firebase-adminsdk-fbsvc@ordertracking-f4874.iam.gserviceaccount.com",
      "client_id": "104987344513190325174",
      "auth_uri": "https://accounts.google.com/o/oauth2/auth",
      "token_uri": "https://oauth2.googleapis.com/token",
      "auth_provider_x509_cert_url":
          "https://www.googleapis.com/oauth2/v1/certs",
      "client_x509_cert_url":
          "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-fbsvc%40ordertracking-f4874.iam.gserviceaccount.com",
      "universe_domain": "googleapis.com",
    };
    final List<String> scopes = [
      'https://www.googleapis.com/auth/firebase.messaging',
    ];
    try {
      http.Client client = await auth.clientViaServiceAccount(
        auth.ServiceAccountCredentials.fromJson(serviceJson),
        scopes,
      );
      auth.AccessCredentials credentials = await auth
          .obtainAccessCredentialsViaServiceAccount(
            auth.ServiceAccountCredentials.fromJson(serviceJson),
            scopes,
            client,
          );
      client.close();
      return credentials.accessToken.data;
    } on Exception catch (e) {
      log("Error Catching token $e");
      return null;
    }
  }

  Future<void> sendNotification({
    required String body,
    required String title,
  }) async {
    const String url =
        "https://fcm.googleapis.com/v1/projects/ordertracking-f4874/messages:send";
    try {
      var accessToken = await getAccessToken();
      var token = await fcm.getToken();
      log('token : $token');
      dio.options.headers['Content-Type'] = 'application/json';
      dio.options.headers['Authorization'] = 'Bearer $accessToken';
      var response = await dio.post(
        url,
        data:
            NotificationLoad(
              token: token!,
              notificationData: NotificationData(
                oldState: "old_state",
                newState: "new_state",
                action: "FLUTTER_NOTIFICATION_CLICK",
              ),
              notificationContent: NotificationContent(
                title: title,
                body: body,
              ),
            ).toJson(),
      );

      log('Response Status Code: ${response.statusCode}');
      log('Response Data: ${response.data}');
    } catch (e) {
      log("Error sending notification: $e");
    }
  }

  Future<void> handelterminatedNotificationClick() async {
    final message = await FirebaseMessaging.instance.getInitialMessage();
    if (message != null) {
      navigateAndSaveState(message);
    } else {
      return;
    }
  }

  Future<void> handelBackgroundNotificationClick() async {
    FirebaseMessaging.onMessageOpenedApp.listen(navigateAndSaveState);
  }

  void navigateAndSaveState(RemoteMessage message) async {
    final newStatus = message.notification?.body?.trim().split(' ').last;
    if (newStatus != null) {
      await const FlutterSecureStorage().write(key: 'last', value: newStatus);
      navigatorKey.currentState?.pushReplacement(
        MaterialPageRoute(builder: (_) => const HomeView()),
      );
    }
  }
}
