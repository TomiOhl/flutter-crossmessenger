class Message {
  final int id;
  final int chatId;
  final String sender;
  final String content;
  final String timestamp;

  const Message({
    this.id,
    this.chatId,
    this.sender,
    this.content,
    this.timestamp
  });

  set id(int value) => id = value;
  set chatId(int value) => chatId = value;
  set sender(String value) => sender = value;
  set content(String value) => content = value;
  set timestamp(String value) => timestamp = value;

  Map<String, dynamic> toMap() {
    Map map = <String, dynamic>{
      'id': id,
      'chatId': chatId,
      'sender': sender,
      'content': content,
      'timestamp': timestamp,
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }
}