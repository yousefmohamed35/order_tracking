import 'package:get_it/get_it.dart';
import 'package:ordertracking/core/helper/firebase_message_helper.dart';
import 'huawei_message_helper.dart';
import 'secure_storage_helper.dart';

final getIt = GetIt.instance;

void setupService() {
  getIt.registerSingleton<FirebaseMessageHelper>(FirebaseMessageHelper());
  getIt.registerSingleton<SecureStorageHelper>(SecureStorageHelper());
  getIt.registerSingleton<HuaweiMessageHelper>(HuaweiMessageHelper());
}
