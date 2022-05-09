// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'common_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommonListResponse _$CommonListResponseFromJson(Map<String, dynamic> json) =>
    CommonListResponse(
      msg: json['msg'] as String,
      data: json['data'] as List<dynamic>?,
    );

Map<String, dynamic> _$CommonListResponseToJson(CommonListResponse instance) =>
    <String, dynamic>{
      'msg': instance.msg,
      'data': instance.data,
    };
