class Data {
  final int id;
  final String title;

  Data({this.id, this.title});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'],
      title: json['title'],
    );
  }
}