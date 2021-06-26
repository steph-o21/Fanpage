class Message {
  Message({
    required this.body,
    required this.sender,
    required this.time
  });

  Message.fromJson(Map<String, Object?> json)
      : this(
      body: json['body']! as String,
      sender: json['sender']! as String,
      time: json['time']! as int
  );

  final String body;
  final String sender;
  final int time;

  Map<String, Object?> toJson() {
    return {
      'body': body,
      'sender': sender,
      'time': time
    };
  }
}