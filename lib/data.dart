import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';
import 'dart:async';
import 'dart:convert';

@JsonSerializable(nullable: false)
Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
    studycode: json['studycode'] as String,
    guid: json['guid'] as String,
    data_version: json['data_version'] as String,
    data: json['data'] as String,
  );
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'studycode': instance.studycode,
      'guid': instance.guid,
      'data_version': instance.data_version,
      'data': instance.data,
    };

class Data {
  final String studycode;
  final String guid;
  final String data;
  final String data_version;

  Data({
    this.studycode,
    this.guid,
    this.data_version,
    this.data,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
  Map<String, dynamic> toJson() => _$DataToJson(this);
}

Future<Data> createData(
    String studycode, String guid, String dataList, String data_version) async {
  Data data = Data(
    studycode: studycode,
    guid: guid,
    data: dataList,
    data_version: data_version,
  );
  String jsonUser = jsonEncode(data);

  final http.Response response = await http.post(
    'https://x0-29.psych.umn.edu/dend/posts',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonUser,
  );

  if (response.statusCode == 200) {
    return Data.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to create data.');
  }
}
