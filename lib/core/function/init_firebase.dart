import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:ordertracking/main.dart';

import '../../firebase_options.dart';
import '../helper/firebase_message_helper.dart';
import '../helper/service_locator.dart';

Future<void> initializeFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  setupService();

  // Separate Firebase push logic into its own service
  await getIt<FirebaseMessageHelper>().initNotification();
}