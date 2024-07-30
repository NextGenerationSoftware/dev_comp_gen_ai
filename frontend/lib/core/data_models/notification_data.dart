class NotificationData {
  String? headline;
  String? text;
  DateTime? timestamp;

  NotificationData({
    this.headline,
    this.text,
    this.timestamp,
  });

  NotificationData.fromJson(Map<String, dynamic> json) {
    headline = json['headline'];
    text = json['text'];
    timestamp = json['timestamp'];
  }
}
