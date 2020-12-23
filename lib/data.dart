class Data {
  final int id;
  final String data;

  Data({this.id, this.data});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'],
      data: json['title'],
    );
  }
}