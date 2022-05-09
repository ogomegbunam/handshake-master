import 'package:json_annotation/json_annotation.dart';

part 'common_response.g.dart';

@JsonSerializable()
class CommonResponse {
  String msg;
  Map<String, dynamic>? data;

  CommonResponse({required this.msg, this.data});

  factory CommonResponse.fromJson(Map<String, dynamic> json) => _$CommonResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CommonResponseToJson(this);
}