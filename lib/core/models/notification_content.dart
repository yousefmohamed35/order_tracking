class NotificationContent {
  final String title;
  final String body;

  NotificationContent({required this.title, required this.body});
  Map<String, dynamic> toJson() {
    return {
      "title":title,
      "body":body,
    };
  }
}
