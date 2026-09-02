class ChatMessageModel {
  final String id;
  final String message;
  final String time;
  final bool isMe;

  ChatMessageModel({
    required this.id,
    required this.message,
    required this.time,
    required this.isMe,
  });

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
    return ChatMessageModel(
      id: json['id'] ?? json['_id'] ?? '',
      message: json['message'] ?? '',
      time: json['time'] ?? '',
      isMe: json['isMe'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'message': message, 'time': time, 'isMe': isMe};
  }
}
