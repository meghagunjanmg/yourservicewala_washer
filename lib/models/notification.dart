class NotificationModel {
  NotificationModel({
    required this.title,
    required this.content,
    required this.timeAgo,
  });
  late final String title;
  late final String content;
  late final String timeAgo;

  NotificationModel.fromJson(Map<String, dynamic> json){
    title = json['title'];
    content = json['content'];
    timeAgo = json['timeAgo'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['title'] = title;
    _data['content'] = content;
    _data['timeAgo'] = timeAgo;
    return _data;
  }
}