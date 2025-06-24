class NotificationData {
  final String? id;
  final String? type;
  final String action;

  NotificationData({this.id, this.type, required this.action});
  Map<String, dynamic> toJson() {
    return {
      "id":id,
      "type":type,
      "click_action":action,
    };
  }
}
