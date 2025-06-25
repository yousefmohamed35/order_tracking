import 'package:get_it/get_it.dart';
import 'package:ordertracking/core/helper/firebase_message_helper.dart';

final getIt = GetIt.instance;

void setupService() {
  getIt.registerSingleton<FirebaseMessageHelper>(FirebaseMessageHelper());
}
