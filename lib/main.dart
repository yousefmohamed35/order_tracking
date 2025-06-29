import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ordertracking/core/function/device_info.dart';
import 'package:ordertracking/core/function/init_firebase.dart';
import 'package:ordertracking/core/helper/service_locator.dart';
import 'core/helper/huawei_message_helper.dart';
import 'home/presentation/view/home_view.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();
  log("🔄 [Background] Message received: ${message.messageId}");
  log("🔄 [Background] Data: ${message.data}");

  final newStatus = message.notification?.body?.trim().split(' ').last;
  await secureStorage.write(key: 'last', value: newStatus);
  log("✅ Saved newStatus in background: $newStatus");
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (await isHuaweiDevice()) {
    await getIt.get<HuaweiMessageHelper>().initHuaweiNotification();
  }
  else{
    await initializeFirebase();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: HomeView(),
    );
  }
}
