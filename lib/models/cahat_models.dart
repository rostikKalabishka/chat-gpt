class ChatModel {
  final String msg;
  final int chatIndex;

  ChatModel({
    required this.msg,
    required this.chatIndex,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
        msg: json['msg'] as String,
        chatIndex: json['chat'] as int,
      );
}
