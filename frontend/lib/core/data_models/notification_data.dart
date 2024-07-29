class NotificationData {
  String? headline;
  String? text;

  NotificationData({
    this.headline,
    this.text,
  });

  NotificationData.fromJson(Map<String, dynamic> json) {
    headline = json['headline'];
    text = json['text'];
  }
}
