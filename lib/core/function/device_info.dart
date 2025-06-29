import 'dart:developer';

import 'package:device_info_plus/device_info_plus.dart';

Future<bool> isHuaweiDevice() async {
  final deviceInfo = await DeviceInfoPlugin().androidInfo;
  final deviceType = deviceInfo.manufacturer.toLowerCase();
  log("deviceType: $deviceType");
  return deviceType.contains('huawei');
}
