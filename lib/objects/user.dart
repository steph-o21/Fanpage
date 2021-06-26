class User {
  User({required this.id,
    required this.first,
    required this.last,
    required this.username,
    required this.type});

  User.fromJson(String id, Map<String, Object?> json)
      : this(
            id: id,
            first: json['first']! as String,
            last: json['first']! as String,
            username: json['first']! as String,
            type: json['type']! as String
        );

  final String id;
  final String last;
  final String first;

  final String username;
  final String type;

  Map<String, Object?> toJson() {
    return {
      'first': first,
      'last': last,
      'timeofRegistration': DateTime.now(),
      'username': username,
      'type': type
    };
  }
}