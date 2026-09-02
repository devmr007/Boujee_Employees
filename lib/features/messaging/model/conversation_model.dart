class ConversationModel {
  final String id;
  final String userName;
  final String userAvatar;
  final String lastMessage;
  final String time;
  final int unreadCount;

  ConversationModel({
    required this.id,
    required this.userName,
    required this.userAvatar,
    required this.lastMessage,
    required this.time,
    this.unreadCount = 0,
  });

  /// Deserialize JSON from API/Socket response
  factory ConversationModel.fromJson(Map<String, dynamic> json) {
    return ConversationModel(
      id: json['id'] ?? json['_id'] ?? '',
      userName: json['userName'] ?? json['name'] ?? '',
      userAvatar: json['userAvatar'] ?? json['avatar'] ?? '',
      lastMessage: json['lastMessage'] ?? '',
      time: json['time'] ?? json['updatedAt'] ?? '',
      unreadCount: json['unreadCount'] ?? 0,
    );
  }

  /// Serialize model to JSON format
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userName': userName,
      'userAvatar': userAvatar,
      'lastMessage': lastMessage,
      'time': time,
      'unreadCount': unreadCount,
    };
  }
}
