class Password {
  final int id;
  final String topNameUrl;
  final String subNameUrl;
  final String password;

  Password(
      {required this.id,
      required this.topNameUrl,
      required this.subNameUrl,
      required this.password});

  factory Password.fromJson(Map<String, dynamic> json) {
    return Password(
        id: json['id'],
        topNameUrl: json['topNameUrl'],
        subNameUrl: json['subNameUrl'],
        password: json['password']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['topNameUrl'] = topNameUrl;
    data['subNameUrl'] = subNameUrl;
    data['password'] = password;
    return data;
  }
}
