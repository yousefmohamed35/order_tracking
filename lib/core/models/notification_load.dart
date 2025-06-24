import 'package:ordertracking/core/models/notification_content.dart';
import 'package:ordertracking/core/models/notification_data.dart';

class NotificationLoad {
  final String token;
  final NotificationContent notificationContent;
  final NotificationData notificationData;

  NotificationLoad({
    required this.token,
    required this.notificationContent,
    required this.notificationData,
  });
  Map<String, dynamic> toJson() {
    return {
      "message":{
        "token":token,
        "notification":notificationContent.toJson(),
        "android": {
          "notification": {
            "notification_priority": "PRIORITY_MAX",
            "sound": "default",
          },
        },
        "apns": {
          "payload": {
            "aps": {
              "content_available": true,
            },
          },
        },
       "data":notificationData.toJson(),
      },
    };
  }
}
