// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model2.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User2 _$User2FromJson(Map<String, dynamic> json) => User2(
      json['id'] as String,
      json['full_name'] as String,
      json['avatar'] as String,
      json['nok_alternate_phone_number'] as String,
      json['nok_phone_number'] as String,
      json['email'] as String,
      json['phone_number'] as String,
      json['address'] as String,
      json['business_name'] as String?,
      json['business_address'] as String?,
      json['vehicle_plate_number'] as String?,
      json['qr_code'] as String?,
      json['current_verification_status'] as String,
      json['createdAt'] as String,
      json['updatedAt'] as String,
    );

Map<String, dynamic> _$User2ToJson(User2 instance) => <String, dynamic>{
      'id': instance.id,
      'full_name': instance.full_name,
      'avatar': instance.avatar,
      'nok_alternate_phone_number': instance.nok_alternate_phone_number,
      'nok_phone_number': instance.nok_phone_number,
      'email': instance.email,
      'phone_number': instance.phone_number,
      'address': instance.address,
      'business_name': instance.business_name,
      'business_address': instance.business_address,
      'vehicle_plate_number': instance.vehicle_plate_number,
      'qr_code': instance.qr_code,
      'current_verification_status': instance.current_verification_status,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
