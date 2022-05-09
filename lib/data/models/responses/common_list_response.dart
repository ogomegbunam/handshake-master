import 'package:json_annotation/json_annotation.dart';

part 'common_list_response.g.dart';

@JsonSerializable()
class CommonListResponse {
  String msg;
  List<dynamic>? data;

  CommonListResponse({ required this.msg, this.data});

  factory CommonListResponse.fromJson(Map<String, dynamic> json) => _$CommonListResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CommonListResponseToJson(this);
}