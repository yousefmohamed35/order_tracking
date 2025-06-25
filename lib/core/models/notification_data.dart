class NotificationData {
  final String? newState;
  final String? oldState;
  final String action;

  NotificationData({this.newState, this.oldState, required this.action});
  Map<String, dynamic> toJson() {
    return {"new_state": newState, "old_state": oldState, "click_action": action};
  }
}
